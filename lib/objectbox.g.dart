// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/todo_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 6457435822011028265),
      name: 'TodoModel',
      lastPropertyId: const IdUid(4, 1381590106721960046),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3686954727114587367),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(2, 4528295833536926153),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(3, 6236121305861422698),
            name: 'body',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1381590106721960046),
            name: 'date',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 6457435822011028265),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    TodoModel: EntityDefinition<TodoModel>(
        model: _entities[0],
        toOneRelations: (TodoModel object) => [],
        toManyRelations: (TodoModel object) => {},
        getId: (TodoModel object) => object.id,
        setId: (TodoModel object, int id) {
          object.id = id;
        },
        objectToFB: (TodoModel object, fb.Builder fbb) {
          final titleOffset = fbb.writeString(object.title);
          final bodyOffset = fbb.writeString(object.body);
          final dateOffset = fbb.writeString(object.date);
          fbb.startTable(5);
          fbb.addOffset(0, titleOffset);
          fbb.addInt64(1, object.id ?? 0);
          fbb.addOffset(2, bodyOffset);
          fbb.addOffset(3, dateOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = TodoModel(
              date: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              title: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 4, ''),
              body: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [TodoModel] entity fields to define ObjectBox queries.
class TodoModel_ {
  /// see [TodoModel.title]
  static final title =
      QueryStringProperty<TodoModel>(_entities[0].properties[0]);

  /// see [TodoModel.id]
  static final id = QueryIntegerProperty<TodoModel>(_entities[0].properties[1]);

  /// see [TodoModel.body]
  static final body =
      QueryStringProperty<TodoModel>(_entities[0].properties[2]);

  /// see [TodoModel.date]
  static final date =
      QueryStringProperty<TodoModel>(_entities[0].properties[3]);
}