// import 'package:hrm_app/core/injectors.dart';
// import 'package:hrm_app/models/action/action_response.dart';
// import 'package:hrm_app/models/sheet_vegetable/sheet_vegetable_detail_record.dart';
// import 'package:hrm_app/models/sheet_vegetable/sheet_vegetable_record.dart';
// import 'package:hrm_app/models/sheet_vegetable/vegetable_supplier_detail.dart';
// import 'package:hrm_app/models/sheet_vegetable/vegetable_supplier_record.dart';
// import 'package:hrm_app/services/network/client/base_client.dart';
// import 'package:hrm_app/services/network/dio/result.dart';

// abstract class SheetVegetableRepository {
//   Future<Result<SheetVegetableRecord>> getSheetVegetable(
//       {required String date, required int restaurantId});

//   Future<Result<ActionResponse>> updateSheetVegetable(
//       {required int sheetId, required SheetVegetableRecord data});

//   Future<Result<ActionResponse>> confirmSheetVegetable({required int sheetId});

//   Future<Result<ActionResponse>> rollbackSheetVegetable({required int sheetId});

//   Future<Result<SheetVegetableDetailRecord>> getSheetVegetableDetail(
//       {required int sheetId, required int itemRecordId});

//   Future<Result<ActionResponse>> updateSheetVegetableDetail(
//       {required int sheetId,
//       required int itemRecordId,
//       required SheetVegetableDetailRecordItem data});

//   Future<Result<PriVegetableSupplierRecord>> getPriSupplierVegetable(
//       {required int sheetId});

//   Future<Result<ActionResponse>> createPriSupplierVegetable(
//       {required int sheetId, required VegetableSupplierDetail data});

//   Future<Result<VegetableSupplierDetail>> getSupplierVegetableDetail(
//       {required int sheetId, required int supplierSheetId});

//   Future<Result<ActionResponse>> deleteSupplierVegetableDetail(
//       {required int sheetId, required int supplierSheetId});

//   Future<Result<ActionResponse>> updateSupplierVegetableDetail(
//       {required int sheetId,
//       required int supplierSheetId,
//       required VegetableSupplierDetail data});
// }

// class SheetVegetableRepositoryImp extends SheetVegetableRepository {
//   final BaseClient _baseClient = injector();

//   @override
//   Future<Result<SheetVegetableRecord>> getSheetVegetable(
//       {required String date, required int restaurantId}) {
//     return runCatchingAsync(() async {
//       final response = await _baseClient.getSheetVegetable(date, restaurantId);
//       return response;
//     });
//   }

//   @override
//   Future<Result<ActionResponse>> updateSheetVegetable(
//       {required int sheetId, required SheetVegetableRecord data}) {
//     return runCatchingAsync(() async {
//       final response = await _baseClient.updateSheetVegetable(sheetId, data);
//       return response;
//     });
//   }

//   @override
//   Future<Result<ActionResponse>> confirmSheetVegetable({required int sheetId}) {
//     return runCatchingAsync(() async {
//       final response = await _baseClient.confirmSheetVegetable(sheetId);
//       return response;
//     });
//   }

//   @override
//   Future<Result<ActionResponse>> rollbackSheetVegetable(
//       {required int sheetId}) {
//     return runCatchingAsync(() async {
//       final response = await _baseClient.rollbackSheetVegetable(sheetId);
//       return response;
//     });
//   }

//   @override
//   Future<Result<SheetVegetableDetailRecord>> getSheetVegetableDetail(
//       {required int sheetId, required int itemRecordId}) {
//     return runCatchingAsync(() async {
//       final response =
//           await _baseClient.getSheetVegetableDetail(sheetId, itemRecordId);
//       return response;
//     });
//   }

//   @override
//   Future<Result<ActionResponse>> updateSheetVegetableDetail(
//       {required int sheetId,
//       required int itemRecordId,
//       required SheetVegetableDetailRecordItem data}) {
//     return runCatchingAsync(() async {
//       final response = await _baseClient.updateSheetVegetableDetail(
//           sheetId, itemRecordId, data);
//       return response;
//     });
//   }

//   @override
//   Future<Result<PriVegetableSupplierRecord>> getPriSupplierVegetable(
//       {required int sheetId}) {
//     return runCatchingAsync(() async {
//       final response = await _baseClient.getPriSupplierVegetable(sheetId);
//       return response;
//     });
//   }

//   @override
//   Future<Result<ActionResponse>> createPriSupplierVegetable(
//       {required int sheetId, required VegetableSupplierDetail data}) {
//     return runCatchingAsync(() async {
//       final response =
//           await _baseClient.createPriSupplierVegetable(sheetId, data);
//       return response;
//     });
//   }

//   @override
//   Future<Result<VegetableSupplierDetail>> getSupplierVegetableDetail(
//       {required int sheetId, required int supplierSheetId}) {
//     return runCatchingAsync(() async {
//       final response = await _baseClient.getSupplierVegetableDetail(
//           sheetId, supplierSheetId);
//       return response;
//     });
//   }

//   @override
//   Future<Result<ActionResponse>> deleteSupplierVegetableDetail(
//       {required int sheetId, required int supplierSheetId}) {
//     return runCatchingAsync(() async {
//       final response = await _baseClient.deleteSupplierVegetableDetail(
//           sheetId, supplierSheetId);
//       return response;
//     });
//   }

//   @override
//   Future<Result<ActionResponse>> updateSupplierVegetableDetail(
//       {required int sheetId,
//       required int supplierSheetId,
//       required VegetableSupplierDetail data}) {
//     return runCatchingAsync(() async {
//       final response = await _baseClient.updateSupplierVegetableDetail(
//           sheetId, supplierSheetId, data);
//       return response;
//     });
//   }
// }
