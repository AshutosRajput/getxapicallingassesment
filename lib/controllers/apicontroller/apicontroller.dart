import 'package:get/get.dart';
import '../../models/company_model.dart';

import '../../services/apiservice.dart';


class ApiController extends GetxController {
  var isLoading = true.obs;
  var isError = false.obs;
  var companyList = <CompanyModel>[].obs;
  var searchResult = <CompanyModel>[].obs;
  RxList<bool> jobStatus = <bool>[].obs;
  var showHeader=true.obs;
  var showSearchField = false.obs;
String _query='';
  ApiService apiService = ApiService();
List<CompanyModel> get allCompanies=>searchResult.isEmpty&&_query.isEmpty?companyList:searchResult;
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      isError(false);
      var companies = await apiService.fetchData();
      jobStatus.value = List.filled(companies.length, false);
      companyList.assignAll(companies);
      searchResult.assignAll(companies);
    } catch (e) {
      isError(true);
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void search(String query) {
    _query=query;
    if (_query.isEmpty) {
      searchResult.clear();
    } else {
      searchResult.assignAll(
        companyList.where((item) => item.title.toLowerCase().startsWith(query.toLowerCase())).toList(),
      );
    }
  }
void showHeaderFunction(){
  showHeader.value = !showHeader.value;
}
  void changeJobStatus(int index) {
    jobStatus[index] = !jobStatus[index];
  }
  void toggleSearchField() {
    showSearchField.value = !showSearchField.value;
  }

}

