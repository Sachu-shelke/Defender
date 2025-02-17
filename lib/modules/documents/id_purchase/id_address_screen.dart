import 'package:flutter/material.dart';
import 'package:defenders/modules/documents/id_purchase/id_purchase_screen.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:defenders/widget/dropdown/custom_drop_down.dart';
import 'package:defenders/widget/textfields/default_text_field.dart';
import 'package:defenders/widget/textfields/mobile_text_field.dart';
import 'package:defenders/widget/textfields/pincode_text_field.dart';

class IdAddressScreem extends StatefulWidget {
  const IdAddressScreem({super.key});

  @override
  State<IdAddressScreem> createState() => _IdAddressScreemState();
}

class _IdAddressScreemState extends State<IdAddressScreem> {
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController address3 = TextEditingController();
  TextEditingController country = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  TextEditingController zip = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _paymentMode = "Home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'ID Card Address'),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropDownString(
                  data: const ["Home", "Office", "Other"],
                  selectedDropdownValue: _paymentMode,
                  onChanged: (String? val) {
                    setState(() {
                      _paymentMode = val!;
                    });
                  },
                  title: "Select Address Type",
                ),
                const Text(
                  "Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                DefaultTextField(
                  controller: address1,
                  labelTextStrr: 'Address',
                ),
                const Text(
                  "City",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                DefaultTextField(
                  controller: address2,
                  labelTextStrr: 'City',
                ),
                const Text(
                  "State",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                DefaultTextField(
                  controller: address3,
                  labelTextStrr: 'State',
                ),
                // Text(
                //   "Country",
                //   style: TextStyle(
                //       fontSize: 18.sp, fontWeight: FontWeight.w600),
                // ),
                // DefaultTextField(
                //   controller: country,
                //   labelTextStrr: 'Country',
                // ),
                const Text(
                  "Zip",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),

                PincodeTextField(
                  controller: zip,
                ),
                const Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                MobileTextField(
                  _phoneController,
                  countryId: '',
                ),
                PrimaryButton(
                  text: "CONFIRM",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IdPurchaseScreen(
                            address: address1.text,
                            addressType: _paymentMode,
                            city: address2.text,
                            state: address3.text,
                            phoneNumber: _phoneController.text,
                            zip: zip.text,
                          ),
                        ),
                      );
                      // Navigator.pop(newcontext);
                      // BlocProvider.of<HomeCubit>(context)
                      //     .addBillingAddressCustomer(
                      //   userId: controller.userDataModelValue[0].id!,
                      //   address: address1.text,
                      //   city: address2.text,
                      //   country: 'India',
                      //   name: name.text,
                      //   addressType: _paymentMode,
                      //   state: address3.text,
                      //   zip: zip.text,
                      //   phone: _phoneController.text,
                      // );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
