#!/bin/bash

# Pedir el nombre para el archivo
echo "Por favor, ingresa el nombre de la clase (por ejemplo, corporativo):"
read nombre_clase

# Convertir el nombre a PascalCase (primera letra en mayúscula)
nombre_clase_pascal=$(echo "$nombre_clase" | sed -r 's/(^|_)([a-z])/\U\2/g')

# Crear el archivo de eventos
archivo_event="${nombre_clase}_event.dart"

cat <<EOL > $archivo_event
part of '${nombre_clase}_bloc.dart';

sealed class ${nombre_clase_pascal}Event extends Equatable {
  const ${nombre_clase_pascal}Event();
  @override
  List<Object> get props => <Object>[];
}

class Initial${nombre_clase_pascal}Event extends ${nombre_clase_pascal}Event {
  const Initial${nombre_clase_pascal}Event();
}

class Set${nombre_clase_pascal}Event extends ${nombre_clase_pascal}Event {
  final ${nombre_clase_pascal}Request request;
  const Set${nombre_clase_pascal}Event(this.request);
}

class Update${nombre_clase_pascal}Event extends ${nombre_clase_pascal}Event {
  final List<${nombre_clase_pascal}Request> requestList;
  const Update${nombre_clase_pascal}Event(this.requestList);
}

class Get${nombre_clase_pascal}Event extends ${nombre_clase_pascal}Event {
  const Get${nombre_clase_pascal}Event();
}

class Activete${nombre_clase_pascal}Event extends ${nombre_clase_pascal}Event {
  const Activete${nombre_clase_pascal}Event();
}

class ErrorForm${nombre_clase_pascal}Event extends ${nombre_clase_pascal}Event {
  final String error;
  const ErrorForm${nombre_clase_pascal}Event(this.error);
}
EOL

# Crear el archivo de estado
archivo_state="${nombre_clase}_state.dart"

cat <<EOL > $archivo_state
part of '${nombre_clase}_bloc.dart';

enum ${nombre_clase_pascal}Status { initial, loading, success, error, consulted, exception }

enum ${nombre_clase_pascal}Status { initial, loading, success, error, consulted, exception }

EOL
