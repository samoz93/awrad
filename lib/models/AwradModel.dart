class WrdModel {
  String uid;
  String wrdDesc;
  String wrdName;
  String wrdType;
  bool hasSound;
  String link;
  String pdfLink;
  bool isPDF;
  num createDate;
  WrdModel({
    this.uid,
    this.wrdDesc,
    this.wrdName,
    this.wrdType,
    this.hasSound,
    this.link,
    this.pdfLink,
    this.isPDF,
    this.createDate,
  });

  WrdModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    wrdDesc = json['wrdDesc'];
    wrdName = json['wrdName'];
    wrdType = json['wrdType'];
    hasSound = json['hasSound'] ?? false;
    link = json['link'] ?? "";
    pdfLink = json['pdfLink'] ?? "";
    isPDF = json['isPDF'] ?? false;
    createDate = json['createDate'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['wrdDesc'] = this.wrdDesc;
    data['wrdName'] = this.wrdName;
    data['wrdType'] = this.wrdType;
    data['hasSound'] = this.hasSound;
    data['link'] = this.hasSound ?? "";

    return data;
  }

  @override
  String toString() {
    return 'WrdModel(uid: $uid, wrdDesc: $wrdDesc, wrdName: $wrdName, wrdType: $wrdType, hasSound: $hasSound, link: $link, pdfLink: $pdfLink, isPDF: $isPDF, createDate: $createDate)';
  }
}
