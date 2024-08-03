class Status{
  final int? job_listing_id;
  final String? status;

  Status({
    this.job_listing_id,
    this.status
  });

    factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      job_listing_id: json['job_listing_id'],
      status: json['status'] ?? '',
    );
  }
}