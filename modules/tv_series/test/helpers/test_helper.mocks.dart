// Mocks generated by Mockito 5.4.2 from annotations
// in tv_series/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i19;
import 'dart:typed_data' as _i20;

import 'package:core/utils/failure.dart' as _i11;
import 'package:core/utils/network_info.dart' as _i18;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i8;
import 'package:tv_series/data/datasources/db/tv_series_database_helper.dart'
    as _i6;
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart'
    as _i17;
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart'
    as _i15;
import 'package:tv_series/data/models/season_detail_model.dart' as _i3;
import 'package:tv_series/data/models/tv_series_detail_model.dart' as _i4;
import 'package:tv_series/data/models/tv_series_model.dart' as _i16;
import 'package:tv_series/data/models/tv_series_table.dart' as _i9;
import 'package:tv_series/domain/entities/season_detail.dart' as _i13;
import 'package:tv_series/domain/entities/tv_series.dart' as _i12;
import 'package:tv_series/domain/entities/tv_series_detail.dart' as _i14;
import 'package:tv_series/domain/repositories/tv_series_repository.dart'
    as _i10;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSeasonDetailModel_1 extends _i1.SmartFake
    implements _i3.SeasonDetailModel {
  _FakeSeasonDetailModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvSeriesDetailModel_2 extends _i1.SmartFake
    implements _i4.TvSeriesDetailModel {
  _FakeTvSeriesDetailModel_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_3 extends _i1.SmartFake implements _i5.Response {
  _FakeResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_4 extends _i1.SmartFake
    implements _i5.StreamedResponse {
  _FakeStreamedResponse_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvSeriesDatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesDatabaseHelper extends _i1.Mock
    implements _i6.TvSeriesDatabaseHelper {
  MockTvSeriesDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i8.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i7.Future<_i8.Database?>.value(),
      ) as _i7.Future<_i8.Database?>);
  @override
  _i7.Future<void> insertCacheTransaction(
    List<_i9.TvSeriesTable>? tvseries,
    String? category,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertCacheTransaction,
          [
            tvseries,
            category,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getCacheTvSeries(String? category) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCacheTvSeries,
          [category],
        ),
        returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> clearCache(String? category) => (super.noSuchMethod(
        Invocation.method(
          #clearCache,
          [category],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<int> insertWatchlist(_i9.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [tvSeries],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlist(_i9.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tvSeries],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getTvSeriesById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesById,
          [id],
        ),
        returnValue: _i7.Future<Map<String, dynamic>?>.value(),
      ) as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTvSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTvSeries,
          [],
        ),
        returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [TvSeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRepository extends _i1.Mock
    implements _i10.TvSeriesRepository {
  MockTvSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>> getAiringToday() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAiringToday,
          [],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>.value(
                _FakeEither_0<_i11.Failure, List<_i12.TvSeries>>(
          this,
          Invocation.method(
            #getAiringToday,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>> getWatchList() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchList,
          [],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>.value(
                _FakeEither_0<_i11.Failure, List<_i12.TvSeries>>(
          this,
          Invocation.method(
            #getWatchList,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>> getPopular() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopular,
          [],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>.value(
                _FakeEither_0<_i11.Failure, List<_i12.TvSeries>>(
          this,
          Invocation.method(
            #getPopular,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>> getTopRated() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRated,
          [],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>.value(
                _FakeEither_0<_i11.Failure, List<_i12.TvSeries>>(
          this,
          Invocation.method(
            #getTopRated,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, _i13.SeasonDetail>> getTvSeriesSeason({
    required int? id,
    required int? seasonNumber,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesSeason,
          [],
          {
            #id: id,
            #seasonNumber: seasonNumber,
          },
        ),
        returnValue:
            _i7.Future<_i2.Either<_i11.Failure, _i13.SeasonDetail>>.value(
                _FakeEither_0<_i11.Failure, _i13.SeasonDetail>(
          this,
          Invocation.method(
            #getTvSeriesSeason,
            [],
            {
              #id: id,
              #seasonNumber: seasonNumber,
            },
          ),
        )),
      ) as _i7.Future<_i2.Either<_i11.Failure, _i13.SeasonDetail>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>
      getTvSeriesRecommendation({required int? id}) => (super.noSuchMethod(
            Invocation.method(
              #getTvSeriesRecommendation,
              [],
              {#id: id},
            ),
            returnValue:
                _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>.value(
                    _FakeEither_0<_i11.Failure, List<_i12.TvSeries>>(
              this,
              Invocation.method(
                #getTvSeriesRecommendation,
                [],
                {#id: id},
              ),
            )),
          ) as _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, _i14.TvSeriesDetail>> getTvSeriesDetail(
          {required int? id}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesDetail,
          [],
          {#id: id},
        ),
        returnValue:
            _i7.Future<_i2.Either<_i11.Failure, _i14.TvSeriesDetail>>.value(
                _FakeEither_0<_i11.Failure, _i14.TvSeriesDetail>(
          this,
          Invocation.method(
            #getTvSeriesDetail,
            [],
            {#id: id},
          ),
        )),
      ) as _i7.Future<_i2.Either<_i11.Failure, _i14.TvSeriesDetail>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>> searchTvSeries(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTvSeries,
          [query],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>.value(
                _FakeEither_0<_i11.Failure, List<_i12.TvSeries>>(
          this,
          Invocation.method(
            #searchTvSeries,
            [query],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, String>> saveWatchlist(
          _i14.TvSeriesDetail? tvSeriesDetail) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [tvSeriesDetail],
        ),
        returnValue: _i7.Future<_i2.Either<_i11.Failure, String>>.value(
            _FakeEither_0<_i11.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [tvSeriesDetail],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i11.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, String>> removeWatchlist(
          _i14.TvSeriesDetail? tvSeriesDetail) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tvSeriesDetail],
        ),
        returnValue: _i7.Future<_i2.Either<_i11.Failure, String>>.value(
            _FakeEither_0<_i11.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [tvSeriesDetail],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i11.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlist,
          [id],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
}

/// A class which mocks [TvSeriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRemoteDataSource extends _i1.Mock
    implements _i15.TvSeriesRemoteDataSource {
  MockTvSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i16.TvSeriesModel>> getAiringToday() => (super.noSuchMethod(
        Invocation.method(
          #getAiringToday,
          [],
        ),
        returnValue:
            _i7.Future<List<_i16.TvSeriesModel>>.value(<_i16.TvSeriesModel>[]),
      ) as _i7.Future<List<_i16.TvSeriesModel>>);
  @override
  _i7.Future<List<_i16.TvSeriesModel>> getPopular() => (super.noSuchMethod(
        Invocation.method(
          #getPopular,
          [],
        ),
        returnValue:
            _i7.Future<List<_i16.TvSeriesModel>>.value(<_i16.TvSeriesModel>[]),
      ) as _i7.Future<List<_i16.TvSeriesModel>>);
  @override
  _i7.Future<List<_i16.TvSeriesModel>> getTopRated() => (super.noSuchMethod(
        Invocation.method(
          #getTopRated,
          [],
        ),
        returnValue:
            _i7.Future<List<_i16.TvSeriesModel>>.value(<_i16.TvSeriesModel>[]),
      ) as _i7.Future<List<_i16.TvSeriesModel>>);
  @override
  _i7.Future<_i3.SeasonDetailModel> getTvSeriesSeason({
    required int? id,
    required int? seasonNumber,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesSeason,
          [],
          {
            #id: id,
            #seasonNumber: seasonNumber,
          },
        ),
        returnValue:
            _i7.Future<_i3.SeasonDetailModel>.value(_FakeSeasonDetailModel_1(
          this,
          Invocation.method(
            #getTvSeriesSeason,
            [],
            {
              #id: id,
              #seasonNumber: seasonNumber,
            },
          ),
        )),
      ) as _i7.Future<_i3.SeasonDetailModel>);
  @override
  _i7.Future<List<_i16.TvSeriesModel>> getTvSeriesRecommendation(
          {required int? id}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesRecommendation,
          [],
          {#id: id},
        ),
        returnValue:
            _i7.Future<List<_i16.TvSeriesModel>>.value(<_i16.TvSeriesModel>[]),
      ) as _i7.Future<List<_i16.TvSeriesModel>>);
  @override
  _i7.Future<_i4.TvSeriesDetailModel> getTvSeriesDetail({required int? id}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesDetail,
          [],
          {#id: id},
        ),
        returnValue: _i7.Future<_i4.TvSeriesDetailModel>.value(
            _FakeTvSeriesDetailModel_2(
          this,
          Invocation.method(
            #getTvSeriesDetail,
            [],
            {#id: id},
          ),
        )),
      ) as _i7.Future<_i4.TvSeriesDetailModel>);
  @override
  _i7.Future<List<_i16.TvSeriesModel>> searchTvSeries(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTvSeries,
          [query],
        ),
        returnValue:
            _i7.Future<List<_i16.TvSeriesModel>>.value(<_i16.TvSeriesModel>[]),
      ) as _i7.Future<List<_i16.TvSeriesModel>>);
}

/// A class which mocks [TvSeriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesLocalDataSource extends _i1.Mock
    implements _i17.TvSeriesLocalDataSource {
  MockTvSeriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i9.TvSeriesTable>> getWatchList() => (super.noSuchMethod(
        Invocation.method(
          #getWatchList,
          [],
        ),
        returnValue:
            _i7.Future<List<_i9.TvSeriesTable>>.value(<_i9.TvSeriesTable>[]),
      ) as _i7.Future<List<_i9.TvSeriesTable>>);
  @override
  _i7.Future<List<_i9.TvSeriesTable>> getCachedAiringToday() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedAiringToday,
          [],
        ),
        returnValue:
            _i7.Future<List<_i9.TvSeriesTable>>.value(<_i9.TvSeriesTable>[]),
      ) as _i7.Future<List<_i9.TvSeriesTable>>);
  @override
  _i7.Future<_i9.TvSeriesTable?> getTvSeriesById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesById,
          [id],
        ),
        returnValue: _i7.Future<_i9.TvSeriesTable?>.value(),
      ) as _i7.Future<_i9.TvSeriesTable?>);
  @override
  _i7.Future<void> cacheAiringToday(List<_i9.TvSeriesTable>? tvSeriesTable) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheAiringToday,
          [tvSeriesTable],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<String> insertWatchList(_i9.TvSeriesTable? tvSeriesTable) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchList,
          [tvSeriesTable],
        ),
        returnValue: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i9.TvSeriesTable? tvSeriesTable) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tvSeriesTable],
        ),
        returnValue: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i18.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<_i20.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i20.Uint8List>.value(_i20.Uint8List(0)),
      ) as _i7.Future<_i20.Uint8List>);
  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i7.Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i7.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
