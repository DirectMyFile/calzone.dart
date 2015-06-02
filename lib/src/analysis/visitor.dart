part of calzone.analysis;

typedef bool VisitorFunction(data, AstNode ast);

class Visitor extends GeneralizingAstVisitor<dynamic> {
  final Map<Type, List<VisitorFunction>> _visitors;
  final data;

  Visitor(this.data, this._visitors);

  @override
  visitNode(AstNode node) {
    bool shouldVisitChildren = true;
    if(_visitors.containsKey(node.runtimeType)) {
      _visitors[node.runtimeType].forEach((visitor) {
        if(visitor(data, node)) shouldVisitChildren = false;
      });
    }

    if(shouldVisitChildren)
      node.visitChildren(this);
  }
}

class VisitorBuilder {
  final Map<Type, List<VisitorFunction>> _visitors = {};

  void where(types, VisitorFunction visitor) {
    if(types is Iterable<Type>) {
      for(var type in types) {
        if(_visitors.containsKey(type))
          _visitors[type].add(visitor);
        else
          _visitors[type] = [visitor];
      }
      return;
    }

    if(_visitors.containsKey(types))
      _visitors[types].add(visitor);
    else
      _visitors[types] = [visitor];
  }

  Visitor build(data) {
    return new Visitor(data, _visitors);
  }
}
