class MessageBox implements Comparable {
  final String name, lastMessage, image, time;
  final bool isActive;
  final int jobId;
  final int traderId;
  final DateTime createdAt;
  //int senderId;

  MessageBox({
    this.name,
    this.jobId,
    this.traderId,
    this.lastMessage,
    this.image,
    this.time,
    this.isActive,
    this.createdAt,
    //this.senderId,
  });

  @override
  int compareTo(other) {
    if (this.createdAt == null && other.createdAt == null)
      return 0;
    else if (this.createdAt == null && other.createdAt != null)
      return 1;
    else if (this.createdAt != null && other.createdAt == null)
      return -1;

    if (this.createdAt.isAfter(other.createdAt) == true)
      return 1;
    else if (this.createdAt.isBefore(other.createdAt) == true)
      return -1;

    return 0;
  }
}

List messageBoxsData = [
  MessageBox(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "packages/local_people_core/assets/images/company-logo.png",
    time: "3m ago",
    isActive: false,
  ),
  MessageBox(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "packages/local_people_core/assets/images/company-logo.png",
    time: "8m ago",
    isActive: true,
  ),
  MessageBox(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "packages/local_people_core/assets/images/company-logo.png",
    time: "5d ago",
    isActive: false,
  ),
  MessageBox(
    name: "Jacob Jones",
    lastMessage: "You’re welcome :)",
    image: "packages/local_people_core/assets/images/company-logo.png",
    time: "5d ago",
    isActive: true,
  ),
  MessageBox(
    name: "Albert Flores",
    lastMessage: "Thanks",
    image: "packages/local_people_core/assets/images/company-logo.png",
    time: "6d ago",
    isActive: false,
  ),
  MessageBox(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "packages/local_people_core/assets/images/company-logo.png",
    time: "3m ago",
    isActive: false,
  ),
  MessageBox(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "packages/local_people_core/assets/images/company-logo.png",
    time: "8m ago",
    isActive: true,
  ),
  MessageBox(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "packages/local_people_core/assets/images/company-logo.png",
    time: "5d ago",
    isActive: false,
  ),
];
