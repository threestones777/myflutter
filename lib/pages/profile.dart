import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Mock数据
  final List<String> _paymentAccounts = [
    '主账户 (余额: 10,000.00)',
    '备用账户 (余额: 5,000.00)'
  ];
  final List<String> _rechargeAccounts = ['VIP专户', '普通专户', '活动专户'];

  // 表单状态
  String? _selectedPaymentAccount;
  String? _selectedRechargeAccount;
  String _rechargeAmount = '';
  String _receivedAmount = '';
  final double _conversionRate = 1.1; // 转换费率
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    //初始化数据
    super.initState();
    _selectedPaymentAccount = _paymentAccounts.first;
    _selectedRechargeAccount = _rechargeAccounts.first;
  }

  // 获取账户余额
  double get _paymentAccountBalance {
    if (_selectedPaymentAccount == null) return 0;
    final balanceStr = _selectedPaymentAccount!.split('余额: ')[1].split(')')[0];
    return double.parse(balanceStr.replaceAll(',', ''));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // 宽度100%
      height: 200,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/card.jpeg'), // 本地图片
          fit: BoxFit.cover, // 图片填充方式
        ),
        boxShadow: [
          //卡片阴影
          BoxShadow(
            color: Colors.red,
            offset: Offset(4.0, 7.0),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            //剪裁为圆角矩形
            child: Image.asset("assets/1.png", width: 60.0),
          ),
          SizedBox(
            height: 10,
          ),
          Text('内容文字',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w800)),
          Text('阿斯UN搜没下来',
              style: TextStyle(color: Color(0xFFc4f8e7), fontSize: 14)),
        ],
      ),
    );
  }

  // 更新到账金额
  void _updateReceivedAmount() {
    if (_rechargeAmount.isEmpty) {
      setState(() {
        _receivedAmount = '';
      });
      return;
    }

    final amount = double.tryParse(_rechargeAmount);
    if (amount != null) {
      setState(() {
        _receivedAmount = (amount / _conversionRate).toStringAsFixed(2);
      });
    }
  }

  // 全部充值
  void _fillMaxAmount() {
    if (_selectedPaymentAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请先选择扣款账户')),
      );
      return;
    }

    setState(() {
      _rechargeAmount = _paymentAccountBalance.toStringAsFixed(2);
      _updateReceivedAmount();
    });
  }

  // 提交表单
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // 表单验证通过，执行充值操作
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('充值确认'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('扣款账户: $_selectedPaymentAccount'),
              Text('充值专户: $_selectedRechargeAccount'),
              Text('充值金额: $_rechargeAmount 元'),
              Text('到账金额: $_receivedAmount 元'),
              const SizedBox(height: 16),
              const Text('确定要进行充值操作吗？'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('充值成功')),
                );
              },
              child: const Text('确认'),
            ),
          ],
        ),
      );
    }
  }
}
