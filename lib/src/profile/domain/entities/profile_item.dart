class ProfileItem {
  final String name, image;
  final int totalJobs;
  final double totalAmountPaid;

  ProfileItem({
    this.name,
    this.image,
    this.totalJobs = 0,
    this.totalAmountPaid = 0.0,
  });
}

ProfileItem traderProfileItem = ProfileItem(
  name: "Tader Full Name Here",
  totalJobs: 0,
  image: "packages/local_people_core/assets/images/company-logo.png",
  totalAmountPaid: 0.0,
);

ProfileItem clieantProfileItem = ProfileItem(
  name: "Client Full Name Here",
  totalJobs: 0,
  image: "packages/local_people_core/assets/images/company-logo.png",
  totalAmountPaid: 0.0,
);