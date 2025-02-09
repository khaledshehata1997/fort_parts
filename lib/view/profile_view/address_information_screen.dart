import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/controllers/address_cubit/address_cubit.dart';
import 'package:fort_parts/controllers/address_cubit/address_states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressInformationScreen extends StatefulWidget {
  const AddressInformationScreen({
    required this.pickedLocation,
    required this.formattedAddress,
    super.key,
  });

  final LatLng pickedLocation;
  final String formattedAddress;

  @override
  State<AddressInformationScreen> createState() => _AddressInformationScreenState();
}

class _AddressInformationScreenState extends State<AddressInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController buildNumberController = TextEditingController();
  final TextEditingController apartmentNumberController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    buildNumberController.dispose();
    apartmentNumberController.dispose();
    landmarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'العناوين',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: SizedBox(
                          width: 375.w,
                          height: 102.h,
                          child: GoogleMap(
                            myLocationEnabled: false,
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                            mapType: MapType.normal,
                            markers: {
                              Marker(
                                markerId: MarkerId("1"),
                                position: widget.pickedLocation,
                                infoWindow: InfoWindow(
                                  title: "",
                                  snippet: "${widget.pickedLocation.latitude}, ${widget.pickedLocation.longitude}",
                                ),
                                icon: BitmapDescriptor.defaultMarker,
                              ),
                            },
                            initialCameraPosition: CameraPosition(
                              target: widget.pickedLocation,
                              zoom: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        height: 60.h,
                        decoration: BoxDecoration(color: AppColors.fffffff, borderRadius: BorderRadius.circular(8.r)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppSVG(
                              svgPath: AppImages.location,
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                                child: AppText(
                              text: "المنطقة: ${widget.formattedAddress}",
                              color: AppColors.f121256,
                              textStyles: AppTextStyles.regular16,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            )),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: AppText(
                                text: "تغيير المنطقة",
                                color: AppColors.fE0AA06,
                                textStyles: AppTextStyles.bold16,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                textDecoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      AppText(
                        text: "النوع",
                        color: Color(0xFF333333),
                        textStyles: AppTextStyles.medium14,
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        width: 375.w,
                        decoration: BoxDecoration(
                          color: AppColors.fffffff,
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(width: 1, color: Color(0xFFE5E5E5)),
                        ),
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: "النوع",
                              prefixStyle: TextStyle(color: Colors.black),
                              contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      AppText(
                        text: "الشارع",
                        color: Color(0xFF333333),
                        textStyles: AppTextStyles.medium14,
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        width: 375.w,
                        decoration: BoxDecoration(
                          color: AppColors.fffffff,
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(width: 1, color: Color(0xFFE5E5E5)),
                        ),
                        child: TextFormField(
                          controller: addressController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: "الشارع",
                              prefixStyle: TextStyle(color: Colors.black),
                              contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: "رقم البيت",
                                  color: Color(0xFF333333),
                                  textStyles: AppTextStyles.medium14,
                                ),
                                SizedBox(height: 16.h),
                                Container(
                                  width: 375.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.fffffff,
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(width: 1, color: Color(0xFFE5E5E5)),
                                  ),
                                  child: TextFormField(
                                    controller: buildNumberController,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    decoration: InputDecoration(
                                        hintText: "رقم البيت",
                                        prefixStyle: TextStyle(color: Colors.black),
                                        contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                          borderRadius: BorderRadius.circular(5),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: "رقم الشقة",
                                  color: Color(0xFF333333),
                                  textStyles: AppTextStyles.medium14,
                                ),
                                SizedBox(height: 16.h),
                                Container(
                                  width: 375.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.fffffff,
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(width: 1, color: Color(0xFFE5E5E5)),
                                  ),
                                  child: TextFormField(
                                    controller: apartmentNumberController,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    decoration: InputDecoration(
                                        hintText: "رقم الشقة",
                                        prefixStyle: TextStyle(color: Colors.black),
                                        contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                          borderRadius: BorderRadius.circular(5),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      AppText(
                        text: "علامة مميزة للعنوان",
                        color: Color(0xFF333333),
                        textStyles: AppTextStyles.medium14,
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        width: 375.w,
                        decoration: BoxDecoration(
                          color: AppColors.fffffff,
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(width: 1, color: Color(0xFFE5E5E5)),
                        ),
                        child: TextFormField(
                          controller: landmarkController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: "علامة مميزة للعنوان",
                              prefixStyle: TextStyle(color: Colors.black),
                              contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
              BlocListener<AddressCubit, AddressStates>(
                listenWhen: (previous, current) => current is AddAddressesState,
                listener: (context, state) {
                  if (state is AddAddressesState && state.stateStatus == StateStatus.success) {
                    final cubit = context.read<AddressCubit>();
                    cubit.fetchAddresses();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: () async {
                    if (nameController.text.isNotEmpty &&
                        addressController.text.isNotEmpty &&
                        buildNumberController.text.isNotEmpty &&
                        landmarkController.text.isNotEmpty) {
                      final cubit = context.read<AddressCubit>();
                      cubit.addAddress(
                        latitude: widget.pickedLocation.latitude.toString(),
                        longitude: widget.pickedLocation.longitude.toString(),
                        name: nameController.text,
                        address: addressController.text,
                        build: buildNumberController.text,
                        floor: apartmentNumberController.text,
                      );
                    }
                  },
                  child: Container(
                    width: 375.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColors.fE0AA06,
                    ),
                    child: Center(
                      child: AppText(
                        text: "حفظ",
                        color: AppColors.fffffff,
                        textStyles: AppTextStyles.medium18,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
