import 'package:json_annotation/json_annotation.dart';
part 'app_control_disclaimer.g.dart';

@JsonSerializable(explicitToJson: true)
class AppControlDisclaimer {
  @JsonKey(defaultValue: '')
  String id;
  @JsonKey(defaultValue: '')
  String disclaimer;

  AppControlDisclaimer()
      : id = '',
        disclaimer = '';

  factory AppControlDisclaimer.fromJson(Map<String, dynamic> json) => _$AppControlDisclaimerFromJson(json);
  Map<String, dynamic> toJson() => _$AppControlDisclaimerToJson(this)..remove('id');
}
