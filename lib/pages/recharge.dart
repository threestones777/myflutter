import 'package:flutter/material.dart';

class RechargeFormPage extends StatefulWidget {
  const RechargeFormPage({super.key});

  @override
  State<RechargeFormPage> createState() => _RechargeFormPageState();
}

class _RechargeFormPageState extends State<RechargeFormPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('账户充值'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 扣款账户下拉选择
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: '扣款账户',
                  border: OutlineInputBorder(),
                ),
                value: _selectedPaymentAccount,
                items: _paymentAccounts.map((account) {
                  return DropdownMenuItem(
                    value: account,
                    child: Text(account),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentAccount = value;
                    _updateReceivedAmount();
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return '请选择扣款账户';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // 充值专户下拉选择
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: '充值专户',
                  border: OutlineInputBorder(),
                ),
                value: _selectedRechargeAccount,
                items: _rechargeAccounts.map((account) {
                  return DropdownMenuItem(
                    value: account,
                    child: Text(account),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRechargeAccount = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return '请选择充值专户';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // 充值金额输入
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '充值金额',
                  hintText: '请输入充值金额',
                  border: OutlineInputBorder(),
                  suffixText: '元',
                ),
                controller: TextEditingController(text: _rechargeAmount),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _rechargeAmount = value;
                    _updateReceivedAmount();
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入充值金额';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null) {
                    return '请输入有效的数字';
                  }
                  if (amount <= 0) {
                    return '充值金额必须大于0';
                  }
                  if (_selectedPaymentAccount != null &&
                      amount > _paymentAccountBalance) {
                    return '充值金额不能超过账户余额';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // 到账金额显示
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '到账金额',
                  border: OutlineInputBorder(),
                  suffixText: '元',
                  filled: true,
                  enabled: false,
                ),
                controller: TextEditingController(text: _receivedAmount),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 24),

              // 按钮行
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('确认充值'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _fillMaxAmount,
                      child: const Text('全部充值'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
