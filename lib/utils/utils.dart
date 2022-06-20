import 'package:image_picker/image_picker.dart';

class UtilsMethods {
  final _imagePicker = ImagePicker();

 Future imagePicker() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }
    return await image.readAsBytes();
  }
}
