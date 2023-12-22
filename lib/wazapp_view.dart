import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wa_zzap/Core/app_buttons.dart';
import 'package:wa_zzap/Core/color_manager.dart';
import 'package:wa_zzap/Core/image_assets.dart';
import 'package:wa_zzap/Core/style_manager.dart';
import 'package:wa_zzap/text_input.dart';

class WAzzapView extends StatefulWidget {
  const WAzzapView({super.key});

  @override
  State<WAzzapView> createState() => _WAzzapViewState();
}

class _WAzzapViewState extends State<WAzzapView> {
  String? _phone;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CountryCode _countryCode;
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    _countryCode =
        const CountryCode(code: 'EG', dialCode: '+20', name: 'Egypt');
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      if (!_autoValidate) {
        setState(() {
          _autoValidate = true;
        });
      }
      String url = '${_countryCode.dialCode}$_phone';
      urlLauncher(Uri.parse('http://wa.me/$url'));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.imagesBackground,
          ),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        SizedBox(
                          width:
                              (MediaQuery.of(context).size.width) * 100 / 375,
                          child: AppTextFormField(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            validator: (_) => isBlank(_phone) ? '' : null,
                            hasConstraints: false,
                            prefixIcon: InkWell(
                              onTap: () async {
                                const countryPicker = FlCountryCodePicker();
                                _countryCode = (await countryPicker.showPicker(
                                    context: context,
                                    initialSelectedLocale: 'EG'))!;
                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _countryCode.dialCode,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  _countryCode.flagImage(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AppTextFormField(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9]'),
                              ),
                            ],
                            onChanged: (phone) {
                              _phone = phone;
                              setState(() {});
                              return null;
                            },
                            onSaved: (phone) => _phone = phone,
                            validator: Validator(
                              rules: [
                                RequiredRule(
                                  validationMessage:
                                      'Please enter a phone number.',
                                ),
                              ],
                            ),
                            hintText: 'Phone Number',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    AppTextButton(
                      onPressed: () {
                        print('${_countryCode.dialCode}$_phone');
                        _submit();
                      },
                      buttonText: 'Send Message',
                      textStyle: StyleManager.font15.copyWith(
                        color: ColorManager.whiteColor,
                      ),
                      backgroundColor: ColorManager.darkBlueColor,
                    ),
                    const Spacer(),
                    Container(
                      width: MediaQuery.sizeOf(context).width * .8,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 5.h,
                      ),
                      decoration: const BoxDecoration(
                        color: ColorManager.semiDarkBlueColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: "Created By  ",
                              style: StyleManager.font13LighterGrayRegular,
                            ),
                            TextSpan(
                              text: "Hussein Mohamed 👨‍💻",
                              style: StyleManager.font18.copyWith(
                                fontFamily: GoogleFonts.singleDay().fontFamily,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.yellowColor,
                              ),
                            ),
                            TextSpan(
                              text: "\n",
                              style: StyleManager.font13LighterGrayRegular,
                            ),
                            TextSpan(
                              text: "Mobile Application Developer",
                              style: StyleManager.font15.copyWith(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> urlLauncher(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('${''}$url');
  }
}
