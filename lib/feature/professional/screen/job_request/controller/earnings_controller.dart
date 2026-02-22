import 'package:get/get.dart';

class TransactionModel {
  final String jobId;
  final String date;
  final String amount;

  const TransactionModel({
    required this.jobId,
    required this.date,
    required this.amount,
  });
}

class PayoutModel {
  final String amount;
  final String date;
  final String status;

  const PayoutModel({
    required this.amount,
    required this.date,
    required this.status,
  });
}

class EarningsController extends GetxController {
  final totalEarnings = '12,450'.obs;
  final growthPercent = '+12% from last month'.obs;
  final thisWeek = '₪2850'.obs;
  final pending = '₪650'.obs;
  final selectedFilter = 'All'.obs;

  final filters = ['All', 'This Week', 'This Month', 'This Year'];

  final transactions = <TransactionModel>[
    const TransactionModel(jobId: 'JOB-001', date: 'Dec 9', amount: '+₪288'),
    const TransactionModel(jobId: 'JOB-002', date: 'Dec 8', amount: '+₪162'),
    const TransactionModel(jobId: 'JOB-003', date: 'Dec 7', amount: '+₪405'),
    const TransactionModel(jobId: 'JOB-004', date: 'Dec 6', amount: '+₪135'),
    const TransactionModel(jobId: 'JOB-005', date: 'Dec 5', amount: '+₪252'),
  ].obs;

  final payouts = <PayoutModel>[
    const PayoutModel(amount: '₪ 3,500', date: 'Dec 3', status: 'Completed'),
    const PayoutModel(amount: '₪ 2,800', date: 'Nov 26', status: 'Completed'),
    const PayoutModel(amount: '₪ 4,200', date: 'Dec 3', status: 'Completed'),
  ].obs;

  void setFilter(String filter) => selectedFilter.value = filter;

  void requestWithdrawal() {
    // TODO: handle withdrawal request
  }
}