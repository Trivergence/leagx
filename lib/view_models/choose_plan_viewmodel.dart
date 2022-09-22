import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/subscription_plan.dart';

class ChoosePlanViewModel extends BaseModel {
  List<SubscriptionPlan> _listOfPlan = [];
  List<SubscriptionPlan> get getPlans => _listOfPlan;

  Future<void> getSubscriptionPlans() async {
    _listOfPlan = await ApiService.getPlans(url: AppUrl.getPlan);
  }
}