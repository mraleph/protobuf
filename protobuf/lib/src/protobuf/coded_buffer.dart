// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

void _writeToCodedBufferWriter(_FieldSet fs, CodedBufferWriter out) {
  // Sorting by tag number isn't required, but it sometimes enables
  // performance optimizations for the receiver. See:
  // https://developers.google.com/protocol-buffers/docs/encoding?hl=en#order

  for (var fi in fs._infosSortedByTag) {
    var value = fs._values[fi.index];
    if (value == null) continue;
    out.writeField(fi.tagNumber, fi.type, value);
  }

  if (fs._hasExtensions) {
    for (var tagNumber in _sorted(fs._extensions._tagNumbers)) {
      var fi = fs._extensions._getInfoOrNull(tagNumber);
      out.writeField(tagNumber, fi.type, fs._extensions._getFieldOrNull(fi));
    }
  }
  if (fs._hasUnknownFields) {
    fs._unknownFields.writeToCodedBufferWriter(out);
  }
}

void _mergeFromCodedBufferReader(
    _FieldSet fs, CodedBufferReader input, ExtensionRegistry registry) {
  assert(registry != null);

  while (true) {
    var tag = input.readTag();
    if (tag == 0) return;
    var wireType = tag & 0x7;
    var tagNumber = tag >> 3;

    var fi = fs._nonExtensionInfo(tagNumber);
    fi ??= registry.getExtension(fs._messageName, tagNumber);

    if (fi == null || !_wireTypeMatches(fi.type, wireType)) {
      if (!fs._ensureUnknownFields().mergeFieldFromBuffer(tag, input)) {
        return;
      }
      continue;
    }

    // Ignore required/optional packed/unpacked.
    var fieldType = fi.type;
    fieldType &= ~(PbFieldType._PACKED_BIT | PbFieldType._REQUIRED_BIT);
    switch (fieldType) {
      case PbFieldType._OPTIONAL_BOOL:
        fs._setFieldUnchecked(fi, input.readBool());
        break;
      case PbFieldType._OPTIONAL_BYTES:
        fs._setFieldUnchecked(fi, input.readBytes());
        break;
      case PbFieldType._OPTIONAL_STRING:
        fs._setFieldUnchecked(fi, input.readString());
        break;
      case PbFieldType._OPTIONAL_FLOAT:
        fs._setFieldUnchecked(fi, input.readFloat());
        break;
      case PbFieldType._OPTIONAL_DOUBLE:
        fs._setFieldUnchecked(fi, input.readDouble());
        break;
      case PbFieldType._OPTIONAL_ENUM:
        var rawValue = input.readEnum();
        var value = fs._meta._decodeEnum(tagNumber, registry, rawValue);
        if (value == null) {
          var unknown = fs._ensureUnknownFields();
          unknown.mergeVarintField(tagNumber, rawValue);
        } else {
          fs._setFieldUnchecked(fi, value);
        }
        break;
      case PbFieldType._OPTIONAL_GROUP:
        var subMessage = fs._meta._makeEmptyMessage(tagNumber, registry);
        var oldValue = fs._getFieldOrNull(fi);
        if (oldValue != null) {
          subMessage.mergeFromMessage(oldValue);
        }
        input.readGroup(tagNumber, subMessage, registry);
        fs._setFieldUnchecked(fi, subMessage);
        break;
      case PbFieldType._OPTIONAL_INT32:
        fs._setFieldUnchecked(fi, input.readInt32());
        break;
      case PbFieldType._OPTIONAL_INT64:
        fs._setFieldUnchecked(fi, input.readInt64());
        break;
      case PbFieldType._OPTIONAL_SINT32:
        fs._setFieldUnchecked(fi, input.readSint32());
        break;
      case PbFieldType._OPTIONAL_SINT64:
        fs._setFieldUnchecked(fi, input.readSint64());
        break;
      case PbFieldType._OPTIONAL_UINT32:
        fs._setFieldUnchecked(fi, input.readUint32());
        break;
      case PbFieldType._OPTIONAL_UINT64:
        fs._setFieldUnchecked(fi, input.readUint64());
        break;
      case PbFieldType._OPTIONAL_FIXED32:
        fs._setFieldUnchecked(fi, input.readFixed32());
        break;
      case PbFieldType._OPTIONAL_FIXED64:
        fs._setFieldUnchecked(fi, input.readFixed64());
        break;
      case PbFieldType._OPTIONAL_SFIXED32:
        fs._setFieldUnchecked(fi, input.readSfixed32());
        break;
      case PbFieldType._OPTIONAL_SFIXED64:
        fs._setFieldUnchecked(fi, input.readSfixed64());
        break;
      case PbFieldType._OPTIONAL_MESSAGE:
        var subMessage = fs._meta._makeEmptyMessage(tagNumber, registry);
        var oldValue = fs._getFieldOrNull(fi);
        if (oldValue != null) {
          subMessage.mergeFromMessage(oldValue);
        }
        input.readMessage(subMessage, registry);
        fs._setFieldUnchecked(fi, subMessage);
        break;
      case PbFieldType._REPEATED_BOOL:
        _readPackable$readBool(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_BYTES:
        fs._ensureRepeatedField(fi).add(input.readBytes());
        break;
      case PbFieldType._REPEATED_STRING:
        fs._ensureRepeatedField(fi).add(input.readString());
        break;
      case PbFieldType._REPEATED_FLOAT:
        _readPackable$readFloat(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_DOUBLE:
        _readPackable$readDouble(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_ENUM:
        _readPackableToListEnum(fs, input, wireType, fi, tagNumber, registry);
        break;
      case PbFieldType._REPEATED_GROUP:
        var subMessage = fs._meta._makeEmptyMessage(tagNumber, registry);
        input.readGroup(tagNumber, subMessage, registry);
        fs._ensureRepeatedField(fi).add(subMessage);
        break;
      case PbFieldType._REPEATED_INT32:
        _readPackable$readInt32(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_INT64:
        _readPackable$readInt64(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_SINT32:
        _readPackable$readSint32(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_SINT64:
        _readPackable$readSint64(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_UINT32:
        _readPackable$readUint32(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_UINT64:
        _readPackable$readUint64(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_FIXED32:
        _readPackable$readFixed32(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_FIXED64:
        _readPackable$readFixed64(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_SFIXED32:
        _readPackable$readSfixed32(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_SFIXED64:
        _readPackable$readSfixed64(fs, input, wireType, fi);
        break;
      case PbFieldType._REPEATED_MESSAGE:
        var subMessage = fs._meta._makeEmptyMessage(tagNumber, registry);
        input.readMessage(subMessage, registry);
        fs._ensureRepeatedField(fi).add(subMessage);
        break;
      case PbFieldType._MAP:
        fs._ensureMapField(fi)._mergeEntry(input, registry);
        break;
      default:
        throw 'Unknown field type $fieldType';
    }
  }
}

void _readPackable$readBool(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      list.add(input.readBool());
    }
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    list.add(input.readBool());
  }
}

void _readPackable$readFloat(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      list.add(input.readFloat());
    }
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    list.add(input.readFloat());
  }
}

void _readPackable$readDouble(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      list.add(input.readDouble());
    }
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    list.add(input.readDouble());
  }
}

void _readPackable$readInt32(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      list.add(input.readInt32());
    }
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    list.add(input.readInt32());
  }
}

void _readPackable$readInt64(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      list.add(input.readInt64());
    }
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    list.add(input.readInt64());
  }
}

void _readPackable$readSint32(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      list.add(input.readSint32());
    }
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    list.add(input.readSint32());
  }
}

void _readPackable$readSint64(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  // var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var list = Int64List(16);
    var len = 0;
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      if (len == list.length) {
        final old = list;
        list = Int64List(list.length * 2);
        for (var i = 0; i < old.length; i++) list[i] = old[i];
      }
      list[len++] = input.readSint64();
    }
    // final out = (fs._ensureRepeatedField(fi) as PbList)._wrappedList;
    //out.length = len;
    //for (var i = 0; i < len; i++) out[i] = list[i];
    fs._setNonExtensionFieldUnchecked(fi, list);
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    fs._ensureRepeatedField(fi).add(input.readSint64());
  }
}

void _readPackable$readUint32(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      list.add(input.readUint32());
    }
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    list.add(input.readUint32());
  }
}

void _readPackable$readUint64(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      list.add(input.readUint64());
    }
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    list.add(input.readUint64());
  }
}

void _readPackable$readFixed32(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      list.add(input.readFixed32());
    }
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    list.add(input.readFixed32());
  }
}

void _readPackable$readFixed64(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      list.add(input.readFixed64());
    }
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    list.add(input.readFixed64());
  }
}

void _readPackable$readSfixed32(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      list.add(input.readSfixed32());
    }
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    list.add(input.readSfixed32());
  }
}

void _readPackable$readSfixed64(
    _FieldSet fs, CodedBufferReader input, int wireType, FieldInfo fi) {
  var list = fs._ensureRepeatedField(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    var byteLimit = input.readInt32();
    if (byteLimit < 0) {
      throw ArgumentError(
          'CodedBufferReader encountered an embedded string or message'
          ' which claimed to have negative size.');
    }
    byteLimit += input._bufferPos;
    var oldLimit = input._currentLimit;
    if ((oldLimit != -1 && byteLimit > oldLimit) ||
        byteLimit > input._sizeLimit) {
      throw InvalidProtocolBufferException.truncatedMessage();
    }
    input._currentLimit = byteLimit;
    while (!input.isAtEnd()) {
      list.add(input.readSfixed64());
    }
    input._currentLimit = oldLimit;
  } else {
    // Not packed.
    list.add(input.readSfixed64());
  }
}

@pragma('vm:prefer-inline')
void _readPackableToListEnum(_FieldSet fs, CodedBufferReader input,
    int wireType, FieldInfo fi, int tagNumber, ExtensionRegistry registry) {
  void readToList(List list) {
    var rawValue = input.readEnum();
    var value = fs._meta._decodeEnum(tagNumber, registry, rawValue);
    if (value == null) {
      var unknown = fs._ensureUnknownFields();
      unknown.mergeVarintField(tagNumber, rawValue);
    } else {
      list.add(value);
    }
  }

  _readPackableToList(fs, input, wireType, fi, readToList);
}

@pragma('vm:prefer-inline')
void _readPackableToList<T>(_FieldSet fs, CodedBufferReader input, int wireType,
    FieldInfo fi, void Function(List<T>) readToList) {
  var list = fs._ensureRepeatedField<T>(fi);

  if (wireType == WIRETYPE_LENGTH_DELIMITED) {
    // Packed.
    input._withLimit(input.readInt32(), () {
      while (!input.isAtEnd()) {
        readToList(list);
      }
    });
  } else {
    // Not packed.
    readToList(list);
  }
}
