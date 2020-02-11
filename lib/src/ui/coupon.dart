import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swappin/src/blocs/coupon_bloc.dart';
import 'package:swappin/src/blocs/coupon_bloc_provider.dart';
import 'package:swappin/src/models/coupon.dart';
import 'package:swappin/src/ui/widgets/no-products.dart';

class CouponScreen extends StatefulWidget {
  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  CouponBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = CouponBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F5F5),
        elevation: 1.0,
        leading: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF05A9C7),
          ),
        ),
        title: Text(
          "Meus Cupons",
          style: TextStyle(color: Color(0xFF05A9C7), fontSize: 18.0),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: _bloc.getCoupon("andre@swappin.io"),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> docs = snapshot.data.documents;
              List<Coupon> couponList = _bloc.mapToList(docList: docs);
              if (couponList.isNotEmpty) {
                return buildList(couponList);
              } else {
                return NoProductsScreen();
              }
            } else {
              return Text("Nenhum pedido realizado.");
            }
          },
        ),
      ),
    );
  }

  ListView buildList(List<Coupon> couponList) {
    return ListView.builder(
      itemCount: couponList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: double.infinity,
          height: 250.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            image: DecorationImage(
              image: NetworkImage(couponList[index].photo),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}
