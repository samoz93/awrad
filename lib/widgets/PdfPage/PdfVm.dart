import 'package:awrad/services/BookService.dart';
import 'package:get/get.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:share/share.dart';
import 'package:stacked/stacked.dart';

class PdfVm extends BaseViewModel {
  final String uid;
  final String link;
  final String name;
  final _ser = Get.find<BookService>();
  PdfVm({this.uid, this.link, this.name});

  PdfController get ctrl => _ctrl;
  PdfController _ctrl;
  String _pth;
  Stream get progress => _ser.progress;
  initBook() async {
    try {
      setBusy(true);
      _pth = await _ser.downloadBook(uid: uid, link: link);
      _ctrl = PdfController(document: PdfDocument.openFile(_pth));
      setBusy(false);
    } catch (e) {
      setError(e.toString());
    }
  }

  share() {
    Share.shareFiles([_pth], subject: name);
  }

  int page = 1;
  void setPage(int pg) {
    page = pg;
    notifyListeners();
  }
}
