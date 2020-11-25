///
//  Generated code. Do not modify.
//  source: osmformat.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Relation_MemberType extends $pb.ProtobufEnum {
  static const Relation_MemberType NODE = Relation_MemberType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NODE');
  static const Relation_MemberType WAY = Relation_MemberType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WAY');
  static const Relation_MemberType RELATION = Relation_MemberType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RELATION');

  static const $core.List<Relation_MemberType> values = <Relation_MemberType> [
    NODE,
    WAY,
    RELATION,
  ];

  static final $core.Map<$core.int, Relation_MemberType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Relation_MemberType valueOf($core.int value) => _byValue[value];

  const Relation_MemberType._($core.int v, $core.String n) : super(v, n);
}

