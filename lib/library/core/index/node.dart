class Node<E>{

  Node(this.data); 

  E data;
  Node? nodeParent;
  Node? nodeChild;
  Node? _lessThanPointer;
  Node? _moreThanPointer;
  Node? get parent => nodeParent;
  set parent(Node? parent) => nodeParent = parent;
  Node? get child => nodeChild;
  set child(Node? child) => nodeChild = child; 
  Node? get lessThanPointer => _lessThanPointer;
  set lessThanPointer(Node? node) => _lessThanPointer = node; 
  Node? get greaterThanPointer => _moreThanPointer;
  set greaterThanPointer(Node? node) => _moreThanPointer = node;
}