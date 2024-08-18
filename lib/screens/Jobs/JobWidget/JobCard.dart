import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/Services/StatusService.dart';
import 'package:tizibane/constants/constants.dart';

class JobCard extends StatefulWidget {
  final String jobListingId;
  final String position;
  final String company;
  final String address;
  final String companyLogo;
  final String closing;

  const JobCard({
    Key? key,
    required this.jobListingId,
    required this.position,
    required this.company,
    required this.address,
    required this.companyLogo,
    required this.closing,
  }) : super(key: key);

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  final StatusService _statusService = Get.put(StatusService());
  ConnectivityService _connectivityService = Get.put(ConnectivityService());
  @override
  void initState() {
    super.initState();
    // if(_connectivityService.isConnected.value)
    // {
    //   _statusService.getJobStatus(widget.jobListingId);
    // }else{
    //   _statusService.getJobStatus(widget.jobListingId);
    // }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String getCompanyInitials(String name) {
      List<String> nameParts = name.split(' ');
      String initials = '';
      for (var part in nameParts) {
        if (part.isNotEmpty) {
          initials += part[0];
        }
      }
      return initials.toUpperCase();
    }

    return SizedBox(
      height: 205,
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.5,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: CachedNetworkImage(
                        imageUrl: companyLogoUrl + widget.companyLogo,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text(
                            getCompanyInitials(widget.company),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          radius: 32.5, // half of the width/height
                        ),
                        height: 65,
                        width: 65,
                        fit: BoxFit.contain,
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.position,
                          style: GoogleFonts.lexendDeca(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.company,
                          style: GoogleFonts.lexendDeca(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.address,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.date_range,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.closing,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(() {
                return _statusService.isLoading.value
                    ? const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2.0,
                        ),
                      )
                    : Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _statusService.jobStatuses[widget.jobListingId] ??
                                "Not Applied",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      );
              }),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
