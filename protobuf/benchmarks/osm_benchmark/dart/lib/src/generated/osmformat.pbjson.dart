///
//  Generated code. Do not modify.
//  source: osmformat.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const HeaderBlock$json = const {
  '1': 'HeaderBlock',
  '2': const [
    const {'1': 'bbox', '3': 1, '4': 1, '5': 11, '6': '.OSMPBF.HeaderBBox', '10': 'bbox'},
    const {'1': 'required_features', '3': 4, '4': 3, '5': 9, '10': 'requiredFeatures'},
    const {'1': 'optional_features', '3': 5, '4': 3, '5': 9, '10': 'optionalFeatures'},
    const {'1': 'writingprogram', '3': 16, '4': 1, '5': 9, '10': 'writingprogram'},
    const {'1': 'source', '3': 17, '4': 1, '5': 9, '10': 'source'},
    const {'1': 'osmosis_replication_timestamp', '3': 32, '4': 1, '5': 3, '10': 'osmosisReplicationTimestamp'},
    const {'1': 'osmosis_replication_sequence_number', '3': 33, '4': 1, '5': 3, '10': 'osmosisReplicationSequenceNumber'},
    const {'1': 'osmosis_replication_base_url', '3': 34, '4': 1, '5': 9, '10': 'osmosisReplicationBaseUrl'},
  ],
};

const HeaderBBox$json = const {
  '1': 'HeaderBBox',
  '2': const [
    const {'1': 'left', '3': 1, '4': 2, '5': 18, '10': 'left'},
    const {'1': 'right', '3': 2, '4': 2, '5': 18, '10': 'right'},
    const {'1': 'top', '3': 3, '4': 2, '5': 18, '10': 'top'},
    const {'1': 'bottom', '3': 4, '4': 2, '5': 18, '10': 'bottom'},
  ],
};

const PrimitiveBlock$json = const {
  '1': 'PrimitiveBlock',
  '2': const [
    const {'1': 'stringtable', '3': 1, '4': 2, '5': 11, '6': '.OSMPBF.StringTable', '10': 'stringtable'},
    const {'1': 'primitivegroup', '3': 2, '4': 3, '5': 11, '6': '.OSMPBF.PrimitiveGroup', '10': 'primitivegroup'},
    const {'1': 'granularity', '3': 17, '4': 1, '5': 5, '7': '100', '10': 'granularity'},
    const {'1': 'lat_offset', '3': 19, '4': 1, '5': 3, '7': '0', '10': 'latOffset'},
    const {'1': 'lon_offset', '3': 20, '4': 1, '5': 3, '7': '0', '10': 'lonOffset'},
    const {'1': 'date_granularity', '3': 18, '4': 1, '5': 5, '7': '1000', '10': 'dateGranularity'},
  ],
};

const PrimitiveGroup$json = const {
  '1': 'PrimitiveGroup',
  '2': const [
    const {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.OSMPBF.Node', '10': 'nodes'},
    const {'1': 'dense', '3': 2, '4': 1, '5': 11, '6': '.OSMPBF.DenseNodes', '10': 'dense'},
    const {'1': 'ways', '3': 3, '4': 3, '5': 11, '6': '.OSMPBF.Way', '10': 'ways'},
    const {'1': 'relations', '3': 4, '4': 3, '5': 11, '6': '.OSMPBF.Relation', '10': 'relations'},
    const {'1': 'changesets', '3': 5, '4': 3, '5': 11, '6': '.OSMPBF.ChangeSet', '10': 'changesets'},
  ],
};

const StringTable$json = const {
  '1': 'StringTable',
  '2': const [
    const {'1': 's', '3': 1, '4': 3, '5': 12, '10': 's'},
  ],
};

const Info$json = const {
  '1': 'Info',
  '2': const [
    const {'1': 'version', '3': 1, '4': 1, '5': 5, '7': '-1', '10': 'version'},
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 3, '10': 'timestamp'},
    const {'1': 'changeset', '3': 3, '4': 1, '5': 3, '10': 'changeset'},
    const {'1': 'uid', '3': 4, '4': 1, '5': 5, '10': 'uid'},
    const {'1': 'user_sid', '3': 5, '4': 1, '5': 13, '10': 'userSid'},
    const {'1': 'visible', '3': 6, '4': 1, '5': 8, '10': 'visible'},
  ],
};

const DenseInfo$json = const {
  '1': 'DenseInfo',
  '2': const [
    const {
      '1': 'version',
      '3': 1,
      '4': 3,
      '5': 5,
      '8': const {'2': true},
      '10': 'version',
    },
    const {
      '1': 'timestamp',
      '3': 2,
      '4': 3,
      '5': 18,
      '8': const {'2': true},
      '10': 'timestamp',
    },
    const {
      '1': 'changeset',
      '3': 3,
      '4': 3,
      '5': 18,
      '8': const {'2': true},
      '10': 'changeset',
    },
    const {
      '1': 'uid',
      '3': 4,
      '4': 3,
      '5': 17,
      '8': const {'2': true},
      '10': 'uid',
    },
    const {
      '1': 'user_sid',
      '3': 5,
      '4': 3,
      '5': 17,
      '8': const {'2': true},
      '10': 'userSid',
    },
    const {
      '1': 'visible',
      '3': 6,
      '4': 3,
      '5': 8,
      '8': const {'2': true},
      '10': 'visible',
    },
  ],
};

const ChangeSet$json = const {
  '1': 'ChangeSet',
  '2': const [
    const {'1': 'id', '3': 1, '4': 2, '5': 3, '10': 'id'},
  ],
};

const Node$json = const {
  '1': 'Node',
  '2': const [
    const {'1': 'id', '3': 1, '4': 2, '5': 18, '10': 'id'},
    const {
      '1': 'keys',
      '3': 2,
      '4': 3,
      '5': 13,
      '8': const {'2': true},
      '10': 'keys',
    },
    const {
      '1': 'vals',
      '3': 3,
      '4': 3,
      '5': 13,
      '8': const {'2': true},
      '10': 'vals',
    },
    const {'1': 'info', '3': 4, '4': 1, '5': 11, '6': '.OSMPBF.Info', '10': 'info'},
    const {'1': 'lat', '3': 8, '4': 2, '5': 18, '10': 'lat'},
    const {'1': 'lon', '3': 9, '4': 2, '5': 18, '10': 'lon'},
  ],
};

const DenseNodes$json = const {
  '1': 'DenseNodes',
  '2': const [
    const {
      '1': 'id',
      '3': 1,
      '4': 3,
      '5': 18,
      '8': const {'2': true},
      '10': 'id',
    },
    const {'1': 'denseinfo', '3': 5, '4': 1, '5': 11, '6': '.OSMPBF.DenseInfo', '10': 'denseinfo'},
    const {
      '1': 'lat',
      '3': 8,
      '4': 3,
      '5': 18,
      '8': const {'2': true},
      '10': 'lat',
    },
    const {
      '1': 'lon',
      '3': 9,
      '4': 3,
      '5': 18,
      '8': const {'2': true},
      '10': 'lon',
    },
    const {
      '1': 'keys_vals',
      '3': 10,
      '4': 3,
      '5': 5,
      '8': const {'2': true},
      '10': 'keysVals',
    },
  ],
};

const Way$json = const {
  '1': 'Way',
  '2': const [
    const {'1': 'id', '3': 1, '4': 2, '5': 3, '10': 'id'},
    const {
      '1': 'keys',
      '3': 2,
      '4': 3,
      '5': 13,
      '8': const {'2': true},
      '10': 'keys',
    },
    const {
      '1': 'vals',
      '3': 3,
      '4': 3,
      '5': 13,
      '8': const {'2': true},
      '10': 'vals',
    },
    const {'1': 'info', '3': 4, '4': 1, '5': 11, '6': '.OSMPBF.Info', '10': 'info'},
    const {
      '1': 'refs',
      '3': 8,
      '4': 3,
      '5': 18,
      '8': const {'2': true},
      '10': 'refs',
    },
  ],
};

const Relation$json = const {
  '1': 'Relation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 2, '5': 3, '10': 'id'},
    const {
      '1': 'keys',
      '3': 2,
      '4': 3,
      '5': 13,
      '8': const {'2': true},
      '10': 'keys',
    },
    const {
      '1': 'vals',
      '3': 3,
      '4': 3,
      '5': 13,
      '8': const {'2': true},
      '10': 'vals',
    },
    const {'1': 'info', '3': 4, '4': 1, '5': 11, '6': '.OSMPBF.Info', '10': 'info'},
    const {
      '1': 'roles_sid',
      '3': 8,
      '4': 3,
      '5': 5,
      '8': const {'2': true},
      '10': 'rolesSid',
    },
    const {
      '1': 'memids',
      '3': 9,
      '4': 3,
      '5': 18,
      '8': const {'2': true},
      '10': 'memids',
    },
    const {
      '1': 'types',
      '3': 10,
      '4': 3,
      '5': 14,
      '6': '.OSMPBF.Relation.MemberType',
      '8': const {'2': true},
      '10': 'types',
    },
  ],
  '4': const [Relation_MemberType$json],
};

const Relation_MemberType$json = const {
  '1': 'MemberType',
  '2': const [
    const {'1': 'NODE', '2': 0},
    const {'1': 'WAY', '2': 1},
    const {'1': 'RELATION', '2': 2},
  ],
};

