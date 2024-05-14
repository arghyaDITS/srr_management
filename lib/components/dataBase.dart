class Category {
  String name;
  String image;
  Category({required this.name, required this.image});
}

List<Category> categoryList = [
  Category(
    name: 'RIGHT HAIR RIGHT NOW',
    image:
        'https://feminaflaunt.com/cdn/shop/files/Website_Service_Images_2.png?v=1674042361&width=550',
  ),
  Category(
    name: 'WAKE UP TO MAKE UP',
    image:
        'https://feminaflaunt.com/cdn/shop/files/Makeup_5d992cc5-06c6-4047-a27a-749d82cbee1b.png?v=1674041123&width=550',
  ),
  Category(
    name: 'SKINSATIONAL',
    image:
        'https://feminaflaunt.com/cdn/shop/files/Facial.png?v=1674041101&width=550',
  ),
  Category(
    name: 'NAILED IT',
    image:
        'https://feminaflaunt.com/cdn/shop/files/Nails.png?v=1674041029&width=550',
  ),
];

class Service {
  String name;
  String image;
  String desc;
  int price;
  int discountedPrice;
  Service({
    required this.name,
    required this.image,
    required this.desc,
    required this.price,
    required this.discountedPrice,
  });
}

List<Service> serviceList = [
  Service(
    name: 'Straight it up (haircut with wash)',
    image:
        'https://i.pinimg.com/736x/0a/03/bf/0a03bf709ae4ee61f87518466927a733.jpg',
    desc: 'desc',
    price: 13000,
    discountedPrice: 12000,
  ),
  Service(
    name: 'Glam Up (Hair Styling)',
    image:
        'https://i.pinimg.com/originals/cd/7a/13/cd7a13cdd6cfe8d3a05e0cc965467f88.jpg',
    desc: 'desc',
    price: 13000,
    discountedPrice: 12000,
  ),
  Service(
    name: 'Color Palate - Highlight/baby light',
    image:
        'https://content.jdmagicbox.com/comp/bangalore/b1/080pxx80.xx80.180209113931.u5b1/catalogue/dmante-unisex-salon-and-skin-spa-c-v-raman-nagar-bangalore-beauty-parlours-6psekas4xn.jpg',
    desc: 'desc',
    price: 15000,
    discountedPrice: 13000,
  ),
  Service(
    name: 'Straightening/smoothing relaxing',
    image:
        'https://www.verywellfamily.com/thmb/m6B6Y18t2A_uQNbFJZLwobN6yUI=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-1196374320-15bde68fdaa049aca2c0bbf0cdc10dec.jpg',
    desc: 'desc',
    price: 20000,
    discountedPrice: 18000,
  ),
  Service(
    name: 'Pure Radiance Essential',
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBC47nZOe3kL9mTt6TJIT_brVQ-e3i6RiMPA&usqp=CAU',
    desc: 'desc',
    price: 12000,
    discountedPrice: 10000,
  ),
];

class Salary {
  String basic, overtime, loan, total, date;
  Salary({
    required this.basic,
    required this.overtime,
    required this.loan,
    required this.total,
    required this.date,
  });
}

List<Salary> salaryStatements = [
  Salary(
    basic: '10000.00',
    overtime: '0.00',
    loan: '0.00',
    total: '10000.00',
    date: '10/5/23',
  ),
  Salary(
    basic: '9500.00',
    overtime: '0.00',
    loan: '0.00',
    total: '9500.00',
    date: '10/4/23',
  ),
  Salary(
    basic: '10000.00',
    overtime: '0.00',
    loan: '0.00',
    total: '10000.00',
    date: '10/3/23',
  ),
  Salary(
    basic: '10000.00',
    overtime: '0.00',
    loan: '0.00',
    total: '10000.00',
    date: '10/2/23',
  ),
];

List<String> galleryImages = [
  'https://images.unsplash.com/photo-1560066984-138dadb4c035?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c2Fsb258ZW58MHx8MHx8fDA%3D',
  'https://images.pexels.com/photos/853427/pexels-photo-853427.jpeg?cs=srgb&dl=pexels-delbeautybox-853427.jpg&fm=jpg',
  'https://img.freepik.com/free-photo/interior-latino-hair-salon_23-2150555185.jpg?size=626&ext=jpg&ga=GA1.1.632798143.1705881600&semt=ais',
  'https://www.salonsmart.com/salon_design_bella_bronze_02.jpg',
];

List inappropriateReview = [
  'Inappropriate content',
  'False Statement',
  'Abusive',
  'Others',
];

class Leave {
  String employeeName,
      image,
      role,
      leaveType,
      leaveDuration,
      fromDate,
      toDate,
      status;
  Leave({
    required this.employeeName,
    required this.image,
    required this.role,
    required this.leaveType,
    required this.leaveDuration,
    required this.fromDate,
    required this.toDate,
    required this.status,
  });
}

List<Leave> leaveList = [
  Leave(
    employeeName: 'Ayan Kuila',
    image: 'image',
    role: 'Hair Stylish',
    leaveType: 'Sick',
    leaveDuration: '3 Days',
    fromDate: '10/5/23',
    toDate: '12/5/23',
    status: 'Pending',
  ),
  Leave(
    employeeName: 'Tithi Biswas',
    image: 'image',
    role: 'Staff',
    leaveType: 'Casual',
    leaveDuration: 'First Half',
    fromDate: '10/5/23',
    toDate: '10/5/23',
    status: 'Approved',
  ),
  Leave(
    employeeName: 'Suvendhu Patro',
    image: 'image',
    role: 'Managerial',
    leaveType: 'Sick',
    leaveDuration: 'Second Half',
    fromDate: '10/5/23',
    toDate: '10/5/23',
    status: 'Approved',
  ),
  Leave(
    employeeName: 'Avishek Bera',
    image: 'image',
    role: 'Accounts',
    leaveType: 'Sick',
    leaveDuration: 'Second Half',
    fromDate: '10/5/23',
    toDate: '10/5/23',
    status: 'Reject',
  ),
];

List<String> leaveTypeList = [
  'Casual',
  'Paid',
  'Sick',
  'Maternity',
  'Paternity',
];

List<String> leaveDurationTypeList = [
  'Full Day',
  'Half Day',
];

List<String> paymentTypeList = [
  'cash',
  'finance',
  'upi',
];

List<String> saloonSectionList = [
  'Reception / cash desk / waiting area',
  'Work Area',
  'Product Area',
];

List<String> collectorList = [
  'Sucharita Roy',
  'Ankita Mondol',
  'Mehtab Alam',
  'Avishek Bera',
];

List<String> jobRoleList = [
  'Manager',
  'Technician',
  'Receptionist',
];

List<String> genderList = [
  'Male',
  'Female',
  'Others',
];

List<String> maritalList = [
  'Married',
  'Unmarried'
];

List<String> bloodGroupList = [
  'A+',
  'A-',
  'B+',
  'B-',
  'O+',
  'O-',
  'AB+',
  'AB-',
];
