import 'node.dart';
enum NodeOffset{offsetToFront, offsetToBack}
class IndexedList<E>{

  IndexedList();

  int _length = 0;
  Node? _first;
  Node? _last;
  int Function(E a, E b)? compare;
  int get length => _length; 
  set length(int length) => _length = length;
  final int lessThan = -1;
  final int equal = 0;
  final int moreThan = 1;
  final int maxHeigth = 50;
  Node? indexRoot;

  void index(){
    Node? node;
    int counter = 0;
    if(length > 0){
      List<Node?> lastNode = List<Node?>.filled(maxHeigth, null);
      node = _first;
      while(node != null){
        counter++;
        _indexInset(node, counter, lastNode);
        node = node.parent;
      }
      indexRoot = _findRoot(counter, lastNode);
      _connectSubTrees(lastNode);
    }
  }
  void _connectSubTrees(List<Node?> lastNode){
    Node? searchPointer;
    int lev;
    int sdk;
    lev = maxHeigth - 1;
    while(lastNode[lev] == null && lev > 1){
      lev--;
    }
    while(lev > 1){
      if(lastNode[lev]!.greaterThanPointer != null){
        lev--;
      } else {
        searchPointer = lastNode[lev]!.lessThanPointer;
        sdk = lev - 1;
        do{
          searchPointer = searchPointer!.greaterThanPointer;
          sdk--;
        } while(searchPointer != null && identical(searchPointer, lastNode[sdk]));
        lastNode[lev]!.greaterThanPointer = lastNode[sdk];
        lev = sdk;
      }
    }
  }
  Node? _findRoot(int counter, List<Node?> lastNode){
    int lev;
    Node? root;
    if(counter != 0){
      lev = maxHeigth -1;
      while(lastNode[lev] == null){
        lev--;
      }
      root = lastNode[lev];
    }
    return root;
  }
  void _indexInset(Node node, int counter, List<Node?> lastNode){
    var lev = _power2(counter);
    node.greaterThanPointer = null;
    node.lessThanPointer = lastNode[lev - 1];
    lastNode[lev] = node;
    if(lastNode[lev + 1] != null){
      if(lastNode[lev + 1]!.greaterThanPointer == null){
        lastNode[lev + 1]!.greaterThanPointer = node;
      }
    }
  }
  int _power2(int elementNo) {
    int lev = 0;
    while ((elementNo % 2) != 1){
      elementNo = (elementNo / 2).floor();
      lev++;
    }
    return ++lev;
  } 
  E find(int test(E a), {E Function()? orElse}) {
    
    Node? node;
    if(indexRoot != null){
      node = indexRoot;
      bool finished = false;
      do{
        if(node == null){
          finished = true;  
        } else {
          if(test(node.data) == equal){
            finished = true;
          } else {
            if(test(node.data) == lessThan){
              node = node.lessThanPointer;
            } else if (test(node.data) == moreThan) {
              node = node.greaterThanPointer;
            }
          }
        }
      } while(finished == false);
      return node!.data;
    }
    if (orElse != null) return orElse();
    throw Exception();
  }

  E firstWhere(bool test(E element), {E Function()? orElse}) {

    Node? node = _first;
    while(node != null){
      if (test(node.data)) return node.data;
      node = node.parent;
    }
    if (orElse != null) return orElse();
    throw Exception();
  }
  void sort(int Function(E a, E b) compareTwo){
    compare = compareTwo;
    _sortNode(_first!, _last!);
  }
  void _sortNode(Node? start, Node? finish){

    E target;
		Node? back;
		Node? front;
		Node? pin;
		Node? pastBack;
    bool frontFound;
		bool backFound;
		bool haveCrossed;

    if(!(identical(start, finish) || identical(start, null) || identical(finish, null))){
      target = finish.data;
      front = start;
      back = nodeOffset(finish, 1, NodeOffset.offsetToFront);
      haveCrossed = false;
      do{
        backFound = false;
        frontFound = false;
        pastBack = nodeOffset(back, 1, NodeOffset.offsetToBack);
        while(!identical(front, pastBack)){
          if(compare!(front!.data, target)  == moreThan){
            frontFound = true;
            break;
          } else {
            front = nodeOffset(front, 1, NodeOffset.offsetToBack);
          }
        }
        if(frontFound){
          while(!identical(back, front)){
            if(compare!(back!.data, target) == lessThan){
              backFound = true;
              break;
            } else {
              back = nodeOffset(back, 1, NodeOffset.offsetToFront);
            }
          }
        }
        if(frontFound && backFound){
          exchangeNodes(front!, back!);
          front = nodeOffset(front, 1, NodeOffset.offsetToBack);
        } else {
          haveCrossed = true;
        } 
      } while (!haveCrossed);
      if(frontFound && !backFound){
        pin = front;
        exchangeNodes(front!, finish);
      } else {
        pin = finish;
      }
      if(!identical(pin, start)){
        _sortNode(start, nodeOffset(pin, 1, NodeOffset.offsetToFront));
      }
      if(!identical(pin, finish)){
        _sortNode(nodeOffset(pin, 1, NodeOffset.offsetToBack), finish);
      }
    }
  }
  void printList(){
    print('=========');
    Node? node = _first;
    while(node != null){
      print('${node.data}');
      node = node.parent;
    }

  }
  void exchangeNodes(Node nodeA, Node nodeB){
    E tempData = nodeA.data;
    nodeA.data = nodeB.data;
    nodeB.data = tempData;
  }
  Node? nodeOffset(Node? node, int offset, NodeOffset direction){

    switch(direction){
      case NodeOffset.offsetToFront:
        if(node == null) return _last!;
        for(var i = 0; i < offset; i++){
          node = node!.child;
          if(node == null) return null;
        }
        break;
      case NodeOffset.offsetToBack:
        if(node == null) return _first!;
        for(var i = 0; i < offset; i++){
          node = node!.parent;
          if(node == null) return null;
        }
        break;
    }
    return node;
  }

  E? pop(){
    switch(length){
      case 0:
        return null;
      case 1:
        Node node = _first!;
        _first = null;
        _last = null;
        return node.data;
      default:
        Node node = _first!;
        _first = _first!.parent;
        _first!.child = null;
        return node.data;
    }
  }
  E? leave(){
    switch(length){
      case 0:
        return null;
      case 1:
        Node node = _last!;
        _first = null;
        _last = null;
        return node.data;
      default:
        Node node = _last!;
        _last!.child!.parent = null;
        _last = _last!.child;
        return node.data;
    }
  }
  void push(E data){
    Node node = Node(data);
    switch(length){
      case 0:
        _first = node;
        _last = node;
        break;
      case 1:
        node.parent = _first;
        _first!.child = node;
        _first = node;
        _last = node.parent;
        break;        
      default:
        node.parent = _first;
        _first!.child = node; 
        _first = node;
    }
    length++;
  }
  void add(E data){
    Node node = Node(data);
    switch(length){
      case 0:
        _first = node;
        _last = node;
        break;
      case 1:
        node.child = _first;
        _first!.parent = node;
        _last = node;
        break;
      default:
        node.child = _last;
        _last!.parent = node;
        _last = node;
    }
    length++;
  }  
}