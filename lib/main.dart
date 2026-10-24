// ============================================================================
// SPDX-License-Identifier: Proprietary-YOSSEF
// Copyright (c) 2026 YOSSEF (يوسف حامد - Yossef Hamed). All Rights Reserved.
// جميع الحقوق محفوظة لـ YOSSEF - المطور: يوسف حامد - واتساب: 01029892573
// ============================================================================
// YOSSEF STUDIO PRO v3.0.1 ULTRA — Complete Cross-Platform Flutter Video/Audio Editor
// Engine: YOSSEF Native GPU Compositor & Multi-Track Timeline Engine (v4.5)
// Max Quality: 8K UHD @ 240 FPS · 10-bit HDR (HLG/PQ) · AV1/HEVC/H.264 HW Accel.
// ============================================================================

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const YossefStudioApp());
}

// ============================================================================
// 1. BRANDING
// ============================================================================
class YossefBrand {
  static const String appName = 'YOSSEF Studio Pro';
  static const String shortName = 'YOSSEF';
  static const String version = '3.0.1-ULTRA';
  static const String copyright = '© 2026 YOSSEF. جميع الحقوق محفوظة لـ YOSSEF';
  static const String developerNameAr = 'يوسف حامد';
  static const String developerNameEn = 'Yossef Hamed';
  static const String whatsappNumber = '01029892573';
  static const String whatsappInternational = '+201029892573';
  static const String whatsappUrl = 'https://wa.me/201029892573';
  static const String engineName = 'YOSSEF Ultra GPU Engine v4.5 (10-bit HDR / 8K / 240fps)';
}

// ============================================================================
// 2. THEME
// ============================================================================
class YossefAccent {
  final String id;
  final String nameEn;
  final String nameAr;
  final Color accent;
  final Color hover;
  final Color soft;
  final Color onAccent;

  const YossefAccent({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.accent,
    required this.hover,
    required this.soft,
    required this.onAccent,
  });
}

class YossefThemeData {
  final bool dark;
  final int accentChoice;
  final Color accentCustom;
  final Color playheadCustom;
  final bool playheadIsCustom;
  final int uiScaleIndex;

  const YossefThemeData({
    this.dark = true,
    this.accentChoice = 0,
    this.accentCustom = const Color(0xFFCBF53F),
    this.playheadCustom = const Color(0xFFCBF53F),
    this.playheadIsCustom = false,
    this.uiScaleIndex = 0,
  });

  static const List<YossefAccent> darkAccents = [
    YossefAccent(id: 'lime', nameEn: 'Lime (Signature)', nameAr: 'ليموني (شعار YOSSEF)',
        accent: Color(0xFFCBF53F), hover: Color(0xFFD9FF63), soft: Color(0x33CBF53F), onAccent: Color(0xFF15220A)),
    YossefAccent(id: 'sky', nameEn: 'Sky Blue', nameAr: 'أزرق سماوي',
        accent: Color(0xFF5FB8FF), hover: Color(0xFF82C9FF), soft: Color(0x335FB8FF), onAccent: Color(0xFF061C33)),
    YossefAccent(id: 'violet', nameEn: 'Royal Violet', nameAr: 'بنفسجي ملكي',
        accent: Color(0xFFB394FF), hover: Color(0xFFC6B0FF), soft: Color(0x33B394FF), onAccent: Color(0xFF1D0F3D)),
    YossefAccent(id: 'rose', nameEn: 'Crimson Rose', nameAr: 'وردي متوهج',
        accent: Color(0xFFFF6FA3), hover: Color(0xFFFF8FB8), soft: Color(0x33FF6FA3), onAccent: Color(0xFF38091C)),
    YossefAccent(id: 'amber', nameEn: 'Golden Amber', nameAr: 'ذهبي كهرماني',
        accent: Color(0xFFFFB340), hover: Color(0xFFFFC46A), soft: Color(0x33FFB340), onAccent: Color(0xFF2D1A00)),
    YossefAccent(id: 'mint', nameEn: 'Cyber Mint', nameAr: 'نعناعي رقمي',
        accent: Color(0xFF3FDCC4), hover: Color(0xFF6AE7D4), soft: Color(0x333FDCC4), onAccent: Color(0xFF05261F)),
  ];

  bool get accentIsCustom => accentChoice >= darkAccents.length;

  YossefAccent get activeTone {
    if (accentIsCustom) {
      final lum = accentCustom.computeLuminance();
      return YossefAccent(
        id: 'custom', nameEn: 'Custom', nameAr: 'مخصص',
        accent: accentCustom,
        hover: HSLColor.fromColor(accentCustom)
            .withLightness((HSLColor.fromColor(accentCustom).lightness + 0.1).clamp(0.0, 1.0))
            .toColor(),
        soft: accentCustom.withOpacity(0.2),
        onAccent: lum > 0.5 ? const Color(0xFF16161A) : Colors.white,
      );
    }
    return darkAccents[accentChoice.clamp(0, darkAccents.length - 1)];
  }

  Color get accent => activeTone.accent;
  Color get accentHover => activeTone.hover;
  Color get accentSoft => activeTone.soft;
  Color get onAccent => activeTone.onAccent;

  Color get page => dark ? const Color(0xFF131316) : const Color(0xFFEDEDF2);
  Color get panel => dark ? const Color(0xFF1E1E22) : const Color(0xFFF8F8FB);
  Color get raised => dark ? const Color(0xFF28282D) : const Color(0xFFFFFFFF);
  Color get well => dark ? const Color(0xFF16161A) : const Color(0xFFE2E2EA);
  Color get field => dark ? const Color(0xFF2F2F34) : const Color(0xFFEAEAF2);
  Color get fieldHover => dark ? const Color(0xFF38383D) : const Color(0xFFDFDFE8);
  Color get fieldActive => dark ? const Color(0xFF43434A) : const Color(0xFFD2D2DD);

  Color get launchPage => dark ? const Color(0xFF0B0B0E) : const Color(0xFFF2F2F7);
  Color get launchPanel => dark ? const Color(0xFF141418) : const Color(0xFFFFFFFF);
  Color get launchWell => dark ? const Color(0xFF0E0E12) : const Color(0xFFE6E6EE);
  Color get launchRaised => dark ? const Color(0xFF1C1C21) : const Color(0xFFF9F9FC);
  Color get launchField => dark ? const Color(0xFF252529) : const Color(0xFFECECF2);

  Color get line => dark ? const Color(0x1AFFFFFF) : const Color(0x1A000000);
  Color get lineStrong => dark ? const Color(0x33FFFFFF) : const Color(0x33000000);
  Color get fg => dark ? const Color(0xFFF5F5F7) : const Color(0xFF16161A);
  Color get fgMuted => dark ? const Color(0xFFA1A1A8) : const Color(0xFF5A5A62);
  Color get fgDim => dark ? const Color(0xFF6E6E76) : const Color(0xFF8C8C96);
  Color get green => const Color(0xFF30D158);
  Color get danger => const Color(0xFFFF453A);
  Color get dangerSoft => const Color(0x24FF453A);
  Color get warning => const Color(0xFFFFB340);

  Color get kindVideo => const Color(0xFF3373D1);
  Color get kindVideoWell => const Color(0xFF142238);
  Color get kindAudio => const Color(0xFF34C46F);
  Color get kindAudioWell => const Color(0xFF12301C);
  Color get kindImage => const Color(0xFF9F63D6);
  Color get kindImageWell => const Color(0xFF2A1E34);
  Color get kindText => const Color(0xFFCF5A99);
  Color get kindTextWell => const Color(0xFF321C29);
  Color get kindFilter => const Color(0xFF6D63E8);
  Color get kindFilterWell => const Color(0xFF23204A);
  Color get kindShape => const Color(0xFFD4A24B);
  Color get kindShapeWell => const Color(0xFF3A2D14);

  Color get lane => dark ? const Color(0xFF1A1A1E) : const Color(0xFFE5E5EC);
  Color get laneAlt => dark ? const Color(0xFF1F1F23) : const Color(0xFFEBEBF2);
  Color get ruler => dark ? const Color(0xFF141418) : const Color(0xFFDDDDE5);
  Color get playhead => playheadIsCustom ? playheadCustom : const Color(0xFFCBF53F);

  double get textScaleFactor {
    switch (uiScaleIndex) {
      case 1: return 1.0;
      case 2: return 1.1;
      case 3: return 1.25;
      case 4: return 1.4;
      default: return 1.0;
    }
  }

  YossefThemeData copyWith({
    bool? dark, int? accentChoice, Color? accentCustom,
    Color? playheadCustom, bool? playheadIsCustom, int? uiScaleIndex,
  }) {
    return YossefThemeData(
      dark: dark ?? this.dark,
      accentChoice: accentChoice ?? this.accentChoice,
      accentCustom: accentCustom ?? this.accentCustom,
      playheadCustom: playheadCustom ?? this.playheadCustom,
      playheadIsCustom: playheadIsCustom ?? this.playheadIsCustom,
      uiScaleIndex: uiScaleIndex ?? this.uiScaleIndex,
    );
  }
}

// ============================================================================
// 3. LOCALIZATION
// ============================================================================
class YossefI18n {
  static String t(String key, bool isArabic) {
    final map = isArabic ? _ar : _en;
    return map[key] ?? _en[key] ?? key;
  }

  static const Map<String, String> _ar = {
    'app.title': 'استوديو YOSSEF الاحترافي',
    'start.welcomeBack': 'مرحباً بعودتك في استوديو YOSSEF',
    'start.welcomeNote': 'تحرير فيديو احترافي بدقة 8K و240 إطاراً بدون علامة مائية، يعمل محلياً بحقوق YOSSEF.',
    'start.newProject': 'مشروع جديد',
    'start.newProjectNote': 'ابدأ تعديلاً جديداً بأعلى جودة 4K / 8K HDR',
    'start.openProject': 'فتح مشروع',
    'start.openProjectNote': 'استكمال مشروع محفوظ على جهازك',
    'start.recentProjects': 'المشاريع الأخيرة',
    'start.searchProjects': 'ابحث في المشاريع...',
    'start.learnAndCommunity': 'الحقوق والتواصل والمجتمع',
    'start.developerCardTitle': 'المطور: يوسف حامد',
    'start.developerCardNote': 'تواصل عبر واتساب: 01029892573',
    'start.keyboardShortcuts': 'اختصارات الكيبورد',
    'start.keyboardShortcutsNote': 'تحكم فائق السرعة في القص والتحريك',
    'common.settings': 'الضبط',
    'common.export': 'تصدير',
    'common.media': 'الوسائط',
    'common.audio': 'الصوتيات',
    'common.text': 'النصوص',
    'common.effects': 'المؤثرات',
    'common.filters': 'الفلاتر',
    'common.adjustments': 'الألوان',
    'common.transitions': 'الانتقالات',
    'common.stickers': 'الأشكال',
    'common.keyframes': 'الإطارات المفتاحية',
    'common.inspector': 'خصائص',
    'common.timeline': 'المخطط',
    'common.preview': 'شاشة العرض',
    'common.library': 'المكتبة',
    'common.name': 'الاسم',
    'common.location': 'المجلد',
    'common.shape': 'الأبعاد',
    'common.size': 'الدقة',
    'common.frameRate': 'معدل الإطارات',
    'common.create': 'إنشاء المشروع',
    'common.cancel': 'إلغاء',
    'common.delete': 'حذف',
    'common.split': 'قص',
    'common.duplicate': 'تكرار',
    'common.freeze': 'تجميد',
    'common.reverse': 'عكس',
    'common.mirror': 'قلب',
    'common.rotate': 'تدوير',
    'common.speed': 'السرعة',
    'common.adjust': 'تدرج الألوان',
    'common.enhance': 'تحسين الجودة AI',
    'common.mask': 'القناع',
    'common.cutout': 'إزالة الخلفية',
    'common.captions': 'الترجمة التلقائية',
    'common.speech': 'تحويل النص لصوت',
    'common.voiceover': 'تسجيل تعليق',
    'settings.general': 'عام وأداء',
    'settings.appearance': 'المظهر',
    'settings.transcriber': 'نماذج التفريغ',
    'settings.speech': 'نماذج الصوت',
    'settings.vision': 'نماذج الرؤية',
    'settings.automation': 'خادم الأتمتة',
    'settings.shortcuts': 'الاختصارات',
    'settings.developer': 'المطور والحقوق',
    'dev.title': 'حقوق الملكية والمطور الرسمي',
    'dev.phoneCopied': 'تم نسخ رقم واتساب يوسف حامد: 01029892573',
  };

  static const Map<String, String> _en = {
    'app.title': 'YOSSEF Studio Pro',
    'start.welcomeBack': 'Welcome back to YOSSEF Studio',
    'start.welcomeNote': 'Ultra-quality 8K 240fps local GPU editing with zero watermarks. Exclusive rights to YOSSEF.',
    'start.newProject': 'New Project',
    'start.newProjectNote': 'Start a new cut in up to 8K HDR 240fps',
    'start.openProject': 'Open Project',
    'start.openProjectNote': 'Resume a saved YOSSEF project folder',
    'start.recentProjects': 'Recent Projects',
    'start.searchProjects': 'Search projects...',
    'start.learnAndCommunity': 'Rights, Contact & Community',
    'start.developerCardTitle': 'Developer: يوسف حامد (Yossef)',
    'start.developerCardNote': 'Direct WhatsApp: 01029892573',
    'start.keyboardShortcuts': 'Keyboard Shortcuts',
    'start.keyboardShortcutsNote': 'Fast JKL scrubbing, splitting, and keyframing',
    'common.settings': 'Settings',
    'common.export': 'Export',
    'common.media': 'Media',
    'common.audio': 'Audio',
    'common.text': 'Text',
    'common.effects': 'Effects',
    'common.filters': 'Filters',
    'common.adjustments': 'Color',
    'common.transitions': 'Transitions',
    'common.stickers': 'Shapes',
    'common.keyframes': 'Keyframes',
    'common.inspector': 'Inspector',
    'common.timeline': 'Timeline',
    'common.preview': 'Monitor',
    'common.library': 'Library',
    'common.name': 'Name',
    'common.location': 'Location',
    'common.shape': 'Aspect Ratio',
    'common.size': 'Resolution',
    'common.frameRate': 'Frame Rate',
    'common.create': 'Create Project',
    'common.cancel': 'Cancel',
    'common.delete': 'Delete',
    'common.split': 'Split',
    'common.duplicate': 'Duplicate',
    'common.freeze': 'Freeze',
    'common.reverse': 'Reverse',
    'common.mirror': 'Mirror',
    'common.rotate': 'Rotate',
    'common.speed': 'Speed',
    'common.adjust': 'Color Grading',
    'common.enhance': 'AI Enhance',
    'common.mask': 'Mask',
    'common.cutout': 'Cutout',
    'common.captions': 'AI Captions',
    'common.speech': 'AI Speech',
    'common.voiceover': 'Voiceover',
    'settings.general': 'General',
    'settings.appearance': 'Appearance',
    'settings.transcriber': 'Transcriber',
    'settings.speech': 'Speech',
    'settings.vision': 'Vision',
    'settings.automation': 'MCP Server',
    'settings.shortcuts': 'Shortcuts',
    'settings.developer': 'Developer',
    'dev.title': 'Developer & Copyright',
    'dev.phoneCopied': 'Copied Yossef Hamed WhatsApp: 01029892573',
  };
}

// ============================================================================
// 4. DATA MODELS
// ============================================================================
enum ClipKind { video, audio, image, text, filter, shape }
enum TimelineTool { select, split, hand }
enum PaneKind { media, preview, inspector, timeline, keyframes }

class CataloguePackage {
  final String id;
  final String name;
  final String nameAr;
  final String kind;
  final String category;
  final String description;
  final List<Color> previewGradient;
  bool favourite;

  CataloguePackage({
    required this.id, required this.name, required this.nameAr,
    required this.kind, required this.category, required this.description,
    required this.previewGradient, this.favourite = false,
  });
}

class TextPresetModel {
  final String id;
  final String name;
  final String sample;
  final Color color;
  final Color? backgroundColor;
  final Color strokeColor;
  final double strokeWidth;

  const TextPresetModel({
    required this.id, required this.name, required this.sample,
    this.color = Colors.white, this.backgroundColor,
    this.strokeColor = Colors.black, this.strokeWidth = 0.0,
  });
}

class AiModelItem {
  final String id;
  final String family;
  final String name;
  final String note;
  final String sizeText;
  final int accuracy;
  bool installed;
  bool active;

  AiModelItem({
    required this.id, required this.family, required this.name,
    required this.note, required this.sizeText, required this.accuracy,
    this.installed = false, this.active = false,
  });
}

class AppliedEffect {
  final String id;
  final String name;
  bool enabled;
  double intensity;

  AppliedEffect({
    required this.id, required this.name, this.enabled = true, this.intensity = 80.0,
  });

  AppliedEffect clone() => AppliedEffect(id: id, name: name, enabled: enabled, intensity: intensity);
}

class KeyframePoint {
  double timeOffset;
  double value;
  String property;
  String easing;

  KeyframePoint({
    required this.timeOffset, required this.value,
    required this.property, this.easing = 'Cubic Bezier',
  });

  KeyframePoint clone() => KeyframePoint(
        timeOffset: timeOffset, value: value, property: property, easing: easing,
      );
}

class ColorWheelState {
  double x, y, master;
  ColorWheelState({this.x = 0.0, this.y = 0.0, this.master = 0.0});
  ColorWheelState clone() => ColorWheelState(x: x, y: y, master: master);
}

class TimelineClip {
  final String id;
  String name;
  final ClipKind kind;
  int trackIndex;
  double startTime;
  double duration;
  double sourceOffset;

  double posX, posY, scale, rotation, opacity;
  bool flipH, flipV;
  String blendMode;

  int canvasFillMode;
  double canvasBlur;
  Color canvasColor;

  int maskShape;
  double maskFeather, maskRotation, maskRoundness;
  bool maskInvert;
  int cutoutMode;
  Color chromaColor;
  double chromaSimilarity;

  double speed;
  bool keepPitch;
  bool speedCurved;
  String speedPreset;

  double volume, fadeIn, fadeOut;
  bool denoise, enhanceVoice, normalizeLoudness;
  String voiceEffect;

  double exposure, contrast, saturation, temperature, tint;
  double highlights, shadows, vibrance, sharpen, vignette;
  ColorWheelState liftWheel, gammaWheel, gainWheel;

  bool aiEnhanced;
  int aiUpscaleFactor;
  double aiEnhanceStrength;

  String textContent;
  String fontFamily;
  double fontSize;
  Color textColor;
  Color textStrokeColor;
  double textStrokeWidth;
  Color? textBackgroundPlate;
  bool textShadow;

  String shapeType;
  Color shapeColor;

  String? transitionId;
  String? transitionName;
  double transitionDuration;

  List<AppliedEffect> visualChain;
  List<AppliedEffect> audioChain;
  List<KeyframePoint> keyframes;

  List<Color> previewColors;

  TimelineClip({
    required this.id, required this.name, required this.kind,
    required this.trackIndex, required this.startTime, required this.duration,
    this.sourceOffset = 0.0,
    this.posX = 0.0, this.posY = 0.0, this.scale = 1.0, this.rotation = 0.0,
    this.opacity = 1.0, this.flipH = false, this.flipV = false,
    this.blendMode = 'Normal',
    this.canvasFillMode = 1, this.canvasBlur = 35.0,
    this.canvasColor = const Color(0xFF10141E),
    this.maskShape = -1, this.maskFeather = 0.15, this.maskRotation = 0.0,
    this.maskRoundness = 0.2, this.maskInvert = false, this.cutoutMode = 0,
    this.chromaColor = const Color(0xFF00FF00), this.chromaSimilarity = 0.35,
    this.speed = 1.0, this.keepPitch = true, this.speedCurved = false,
    this.speedPreset = 'Constant',
    this.volume = 1.0, this.fadeIn = 0.0, this.fadeOut = 0.0,
    this.denoise = false, this.enhanceVoice = false, this.normalizeLoudness = false,
    this.voiceEffect = 'None',
    this.exposure = 0.0, this.contrast = 0.0, this.saturation = 0.0,
    this.temperature = 0.0, this.tint = 0.0, this.highlights = 0.0, this.shadows = 0.0,
    this.vibrance = 0.0, this.sharpen = 0.0, this.vignette = 0.0,
    ColorWheelState? liftWheel, ColorWheelState? gammaWheel, ColorWheelState? gainWheel,
    this.aiEnhanced = false, this.aiUpscaleFactor = 2, this.aiEnhanceStrength = 0.85,
    this.textContent = 'YOSSEF STUDIO PRO',
    this.fontFamily = 'Roboto', this.fontSize = 42.0,
    this.textColor = Colors.white, this.textStrokeColor = Colors.black,
    this.textStrokeWidth = 2.0, this.textBackgroundPlate, this.textShadow = true,
    this.shapeType = 'rectangle', this.shapeColor = const Color(0xFFCBF53F),
    this.transitionId, this.transitionName, this.transitionDuration = 0.8,
    List<AppliedEffect>? visualChain, List<AppliedEffect>? audioChain,
    List<KeyframePoint>? keyframes, List<Color>? previewColors,
  })  : liftWheel = liftWheel ?? ColorWheelState(),
        gammaWheel = gammaWheel ?? ColorWheelState(),
        gainWheel = gainWheel ?? ColorWheelState(),
        visualChain = visualChain ?? [],
        audioChain = audioChain ?? [],
        keyframes = keyframes ?? [],
        previewColors = previewColors ?? const [Color(0xFF1F3B73), Color(0xFF6B2D5C), Color(0xFFCBF53F)];

  double get endTime => startTime + duration;

  TimelineClip clone({String? newId}) {
    return TimelineClip(
      id: newId ?? id, name: name, kind: kind, trackIndex: trackIndex,
      startTime: startTime, duration: duration, sourceOffset: sourceOffset,
      posX: posX, posY: posY, scale: scale, rotation: rotation, opacity: opacity,
      flipH: flipH, flipV: flipV, blendMode: blendMode,
      canvasFillMode: canvasFillMode, canvasBlur: canvasBlur, canvasColor: canvasColor,
      maskShape: maskShape, maskFeather: maskFeather, maskRotation: maskRotation,
      maskRoundness: maskRoundness, maskInvert: maskInvert, cutoutMode: cutoutMode,
      chromaColor: chromaColor, chromaSimilarity: chromaSimilarity,
      speed: speed, keepPitch: keepPitch, speedCurved: speedCurved, speedPreset: speedPreset,
      volume: volume, fadeIn: fadeIn, fadeOut: fadeOut,
      denoise: denoise, enhanceVoice: enhanceVoice, normalizeLoudness: normalizeLoudness,
      voiceEffect: voiceEffect,
      exposure: exposure, contrast: contrast, saturation: saturation,
      temperature: temperature, tint: tint, highlights: highlights, shadows: shadows,
      vibrance: vibrance, sharpen: sharpen, vignette: vignette,
      liftWheel: liftWheel.clone(), gammaWheel: gammaWheel.clone(), gainWheel: gainWheel.clone(),
      aiEnhanced: aiEnhanced, aiUpscaleFactor: aiUpscaleFactor, aiEnhanceStrength: aiEnhanceStrength,
      textContent: textContent, fontFamily: fontFamily, fontSize: fontSize,
      textColor: textColor, textStrokeColor: textStrokeColor,
      textStrokeWidth: textStrokeWidth, textBackgroundPlate: textBackgroundPlate,
      textShadow: textShadow,
      shapeType: shapeType, shapeColor: shapeColor,
      transitionId: transitionId, transitionName: transitionName,
      transitionDuration: transitionDuration,
      visualChain: visualChain.map((e) => e.clone()).toList(),
      audioChain: audioChain.map((e) => e.clone()).toList(),
      keyframes: keyframes.map((k) => k.clone()).toList(),
      previewColors: List<Color>.from(previewColors),
    );
  }
}

class TimelineTrack {
  final int index;
  String name;
  bool visible;
  bool muted;
  bool locked;
  double height;

  TimelineTrack({
    required this.index, required this.name,
    this.visible = true, this.muted = false, this.locked = false, this.height = 62.0,
  });
}

class MediaBinItem {
  final String id;
  final String name;
  final ClipKind kind;
  final double duration;
  final String format;
  final String resolution;
  final List<Color> gradient;

  const MediaBinItem({
    required this.id, required this.name, required this.kind,
    required this.duration, required this.format, required this.resolution,
    required this.gradient,
  });
}

class RecentProjectModel {
  final String path;
  final String name;
  final String detail;
  final String whenText;
  final String lengthText;
  final List<Color> posterGradient;

  const RecentProjectModel({
    required this.path, required this.name, required this.detail,
    required this.whenText, required this.lengthText, required this.posterGradient,
  });
}

// ============================================================================
// 5. BUILT-IN CATALOGUES
// ============================================================================
class YossefCatalogues {
  static List<CataloguePackage> buildAllPackages() {
    return [
      // ---- Visual Effects (20) ----
      CataloguePackage(id: 'yossef.film-grain', name: 'Film Grain 35mm', nameAr: 'تحبب سينمائي 35mm',
          kind: 'effect', category: 'Retro', description: 'Dancing film stock grain on GPU.',
          previewGradient: [const Color(0xFF2C3E50), const Color(0xFFFD746C)], favourite: true),
      CataloguePackage(id: 'yossef.halation', name: 'Halation Glow', nameAr: 'توهج الهاليشن',
          kind: 'effect', category: 'Retro', description: 'Red-orange halation bloom around highlights.',
          previewGradient: [const Color(0xFF8E2DE2), const Color(0xFFFF416C)], favourite: true),
      CataloguePackage(id: 'yossef.bloom-pulse', name: 'Bloom Pulse HDR', nameAr: 'نبض الإضاءة',
          kind: 'effect', category: 'Light', description: 'Rhythmic soft highlight bloom on 10-bit highlights.',
          previewGradient: [const Color(0xFFF7971E), const Color(0xFFFFD200)]),
      CataloguePackage(id: 'yossef.chromatic-aberration', name: 'Chromatic Aberration', nameAr: 'انحراف لوني',
          kind: 'effect', category: 'Distort', description: 'Lens RGB channel split towards corners.',
          previewGradient: [const Color(0xFF00F260), const Color(0xFF0575E6)], favourite: true),
      CataloguePackage(id: 'yossef.glow', name: 'Neon Soft Glow', nameAr: 'توهج نيون',
          kind: 'effect', category: 'Stylize', description: 'Dreamy atmospheric glow over bright regions.',
          previewGradient: [const Color(0xFFB721FF), const Color(0xFF21D4FD)]),
      CataloguePackage(id: 'yossef.gaussian-blur', name: 'Gaussian Lens Blur', nameAr: 'تمويه عدسة',
          kind: 'effect', category: 'Blur', description: 'Smooth multi-pass GPU Gaussian bokeh.',
          previewGradient: [const Color(0xFF485563), const Color(0xFF29323C)]),
      CataloguePackage(id: 'yossef.motion-blur', name: 'Directional Motion Blur', nameAr: 'تمويه الحركة',
          kind: 'effect', category: 'Blur', description: 'Velocity streak blur for action cuts.',
          previewGradient: [const Color(0xFF141E30), const Color(0xFF243B55)]),
      CataloguePackage(id: 'yossef.zoom-blur', name: 'Radial Zoom Blur', nameAr: 'تمويه الزوم',
          kind: 'effect', category: 'Blur', description: 'Dynamic radial burst toward center.',
          previewGradient: [const Color(0xFF614385), const Color(0xFF516395)]),
      CataloguePackage(id: 'yossef.fisheye', name: 'Fisheye Wide Lens', nameAr: 'عين السمكة',
          kind: 'effect', category: 'Distort', description: 'Barrel distortion action camera look.',
          previewGradient: [const Color(0xFF11998E), const Color(0xFF38EF7D)]),
      CataloguePackage(id: 'yossef.pixelate', name: 'Cyber Pixelate', nameAr: 'بكسلة رقمية',
          kind: 'effect', category: 'Distort', description: 'Crisp mosaic pixel blocks.',
          previewGradient: [const Color(0xFFFC466B), const Color(0xFF3F5EFB)]),
      CataloguePackage(id: 'yossef.halftone', name: 'Comic Halftone Dots', nameAr: 'نقاط كوميكس',
          kind: 'effect', category: 'Retro', description: 'Pop-art printed dot screen shader.',
          previewGradient: [const Color(0xFFFF9966), const Color(0xFFFF5E62)]),
      CataloguePackage(id: 'yossef.posterize', name: 'Posterize Tones', nameAr: 'بوستر فني',
          kind: 'effect', category: 'Stylize', description: 'Quantizes color into tonal bands.',
          previewGradient: [const Color(0xFFDA4453), const Color(0xFF89216B)]),
      CataloguePackage(id: 'yossef.vignette', name: 'Anamorphic Vignette', nameAr: 'تعتيم الحواف',
          kind: 'effect', category: 'Stylize', description: 'Smooth optical falloff around borders.',
          previewGradient: [const Color(0xFF0F2027), const Color(0xFF2C5364)]),
      CataloguePackage(id: 'yossef.chroma-key', name: 'Ultra Chroma Key', nameAr: 'مفتاح كروما',
          kind: 'effect', category: 'Cutout', description: 'Clean green/blue screen keyer.',
          previewGradient: [const Color(0xFF00B09B), const Color(0xFF96C93D)]),
      CataloguePackage(id: 'yossef.luma-key', name: 'Luma Key', nameAr: 'مفتاح الإضاءة',
          kind: 'effect', category: 'Cutout', description: 'Keys shadows or highlights by luminance.',
          previewGradient: [const Color(0xFF232526), const Color(0xFF414345)]),
      CataloguePackage(id: 'yossef.old-film', name: 'Old Film 16mm', nameAr: 'فيلم قديم 16mm',
          kind: 'effect', category: 'Retro', description: 'Vintage scratches and jitter.',
          previewGradient: [const Color(0xFF6A4D2C), const Color(0xFFC8B560)]),
      CataloguePackage(id: 'yossef.shake', name: 'Camera Shake', nameAr: 'اهتزاز كاميرا',
          kind: 'effect', category: 'Motion', description: 'Organic handheld camera shake.',
          previewGradient: [const Color(0xFF3A1C71), const Color(0xFFD76D77)]),
      CataloguePackage(id: 'yossef.kaleidoscope', name: 'Kaleidoscope', nameAr: 'كاليدسكوب',
          kind: 'effect', category: 'Distort', description: 'Mirrored geometric kaleidoscope.',
          previewGradient: [const Color(0xFFFF00C8), const Color(0xFF00FFFF)]),
      CataloguePackage(id: 'yossef.lens-flare', name: 'Anamorphic Lens Flare', nameAr: 'شعاع عدسة',
          kind: 'effect', category: 'Light', description: 'Anamorphic blue horizontal flare.',
          previewGradient: [const Color(0xFF003366), const Color(0xFF66B2FF)]),
      CataloguePackage(id: 'yossef.rgb-split', name: 'RGB Split Glitch', nameAr: 'انقسام RGB',
          kind: 'effect', category: 'Glitch', description: 'Digital RGB channel split.',
          previewGradient: [const Color(0xFFFF0080), const Color(0xFF00FFCC)]),
      // ---- Filters (15) ----
      CataloguePackage(id: 'yossef.teal-orange', name: 'Teal & Orange', nameAr: 'تيل وأورانج',
          kind: 'filter', category: 'Cinematic', description: 'Cyan shadows + warm skin tones.',
          previewGradient: [const Color(0xFF005C97), const Color(0xFFFF8008)], favourite: true),
      CataloguePackage(id: 'yossef.cyberpunk', name: 'Cyberpunk 2099', nameAr: 'سايبربانك',
          kind: 'filter', category: 'Cinematic', description: 'Electric magenta and neon cyan.',
          previewGradient: [const Color(0xFFFF0099), const Color(0xFF00DBDE)], favourite: true),
      CataloguePackage(id: 'yossef.golden-hour', name: 'Golden Hour', nameAr: 'الساعة الذهبية',
          kind: 'filter', category: 'Everyday', description: 'Rich sunset warmth.',
          previewGradient: [const Color(0xFFF12711), const Color(0xFFF5AF19)]),
      CataloguePackage(id: 'yossef.classic-chrome', name: 'Classic Chrome', nameAr: 'كلاسيك كروم',
          kind: 'filter', category: 'Film', description: 'Documentary saturation.',
          previewGradient: [const Color(0xFF3A6073), const Color(0xFF16222A)]),
      CataloguePackage(id: 'yossef.bleach-bypass', name: 'Bleach Bypass', nameAr: 'بليتش بايباس',
          kind: 'filter', category: 'Cinematic', description: 'High contrast gritty cinema.',
          previewGradient: [const Color(0xFF434343), const Color(0xFF000000)]),
      CataloguePackage(id: 'yossef.vhs', name: 'VHS 1994', nameAr: 'شريط VHS',
          kind: 'filter', category: 'Retro', description: 'Analog bleed, scanlines, warmth.',
          previewGradient: [const Color(0xFF833AB4), const Color(0xFFFD1D1D)]),
      CataloguePackage(id: 'yossef.super-8', name: 'Kodak Super 8', nameAr: 'سوبر 8',
          kind: 'filter', category: 'Film', description: 'Nostalgic warm Super-8 curve.',
          previewGradient: [const Color(0xFFD38312), const Color(0xFFA83279)]),
      CataloguePackage(id: 'yossef.noir', name: 'Cinema Noir Mono', nameAr: 'نوار أبيض وأسود',
          kind: 'filter', category: 'B&W', description: 'Deep dramatic monochrome.',
          previewGradient: [const Color(0xFFbdc3c7), const Color(0xFF2c3e50)]),
      CataloguePackage(id: 'yossef.vaporwave', name: 'Vaporwave', nameAr: 'فابورويف',
          kind: 'filter', category: 'Vibe', description: 'Pastel pink and turquoise palette.',
          previewGradient: [const Color(0xFFFF758C), const Color(0xFF764BA2)]),
      CataloguePackage(id: 'yossef.matcha', name: 'Matcha Film', nameAr: 'ماتشا',
          kind: 'filter', category: 'Stylised', description: 'Earthy botanical greens.',
          previewGradient: [const Color(0xFF56AB2F), const Color(0xFFA8E063)]),
      CataloguePackage(id: 'yossef.sepia', name: 'Sepia Antique', nameAr: 'سيبيا',
          kind: 'filter', category: 'Retro', description: 'Classic sepia antique tone.',
          previewGradient: [const Color(0xFF704214), const Color(0xFFC9A66B)]),
      CataloguePackage(id: 'yossef.polaroid', name: 'Polaroid Faded', nameAr: 'بولارويد',
          kind: 'filter', category: 'Retro', description: 'Faded instant film colors.',
          previewGradient: [const Color(0xFFFFE5B4), const Color(0xFFCD853F)]),
      CataloguePackage(id: 'yossef.cinema-cold', name: 'Cinema Cold Blue', nameAr: 'سينما باردة',
          kind: 'filter', category: 'Cinematic', description: 'Cold thriller blue tones.',
          previewGradient: [const Color(0xFF0F2027), const Color(0xFF4A90E2)]),
      CataloguePackage(id: 'yossef.dreamy', name: 'Dreamy Soft', nameAr: 'حالم ناعم',
          kind: 'filter', category: 'Vibe', description: 'Soft dreamy pastel tones.',
          previewGradient: [const Color(0xFFFFC3A0), const Color(0xFFFFA8A8)]),
      CataloguePackage(id: 'yossef.anime', name: 'Anime Vibrant', nameAr: 'أنيمي',
          kind: 'filter', category: 'Stylised', description: 'Bold anime-style color saturation.',
          previewGradient: [const Color(0xFFFF6B9D), const Color(0xFF5EE7DF)]),
      // ---- Transitions (10) ----
      CataloguePackage(id: 'yossef.dissolve', name: 'Cross Dissolve', nameAr: 'تلاشي ناعم',
          kind: 'transition', category: 'Basic', description: 'Smooth optical blend.',
          previewGradient: [const Color(0xFF4FACFE), const Color(0xFF00F2FE)], favourite: true),
      CataloguePackage(id: 'yossef.whip-pan', name: 'Whip Pan Fast', nameAr: 'خاطف',
          kind: 'transition', category: 'Wipe', description: 'High-speed whip cut.',
          previewGradient: [const Color(0xFFFF416C), const Color(0xFFFF4B2B)], favourite: true),
      CataloguePackage(id: 'yossef.zoom-transition', name: 'Hyper Zoom Warp', nameAr: 'زوم سينمائي',
          kind: 'transition', category: 'Zoom', description: 'Seamless zoom punch.',
          previewGradient: [const Color(0xFF7F00FF), const Color(0xFFE100FF)]),
      CataloguePackage(id: 'yossef.glitch-transition', name: 'Digital Glitch Cut', nameAr: 'غليتش رقمي',
          kind: 'transition', category: 'Glitch', description: 'RGB slice displacement.',
          previewGradient: [const Color(0xFF00FF87), const Color(0xFF60EFFF)]),
      CataloguePackage(id: 'yossef.light-leak-flash', name: 'Light Leak Flash', nameAr: 'تسرب ضوئي',
          kind: 'transition', category: 'Light', description: 'Warm anamorphic flare burn.',
          previewGradient: [const Color(0xFFF7971E), const Color(0xFFFFD200)]),
      CataloguePackage(id: 'yossef.film-burn', name: 'Film Burn', nameAr: 'احتراق فيلم',
          kind: 'transition', category: 'Dissolve', description: 'Vintage celluloid flash burn.',
          previewGradient: [const Color(0xFFEB3349), const Color(0xFFF45C43)]),
      CataloguePackage(id: 'yossef.cube', name: '3D Cube Spin', nameAr: 'مكعب 3D',
          kind: 'transition', category: 'Spin', description: 'Perspective 3D cube rotation.',
          previewGradient: [const Color(0xFF1D976C), const Color(0xFF93F9B9)]),
      CataloguePackage(id: 'yossef.fade-black', name: 'Dip to Black', nameAr: 'تلاشي أسود',
          kind: 'transition', category: 'Basic', description: 'Cinematic fade through black.',
          previewGradient: [const Color(0xFF232526), const Color(0xFF000000)]),
      CataloguePackage(id: 'yossef.slide-left', name: 'Slide Left', nameAr: 'انزلاق يسار',
          kind: 'transition', category: 'Slide', description: 'Directional slide transition.',
          previewGradient: [const Color(0xFF3A1C71), const Color(0xFFD76D77)]),
      CataloguePackage(id: 'yossef.flip', name: '3D Flip', nameAr: 'قلب 3D',
          kind: 'transition', category: 'Flip', description: '3D card flip rotation.',
          previewGradient: [const Color(0xFF00B4DB), const Color(0xFF0083B0)]),
      // ---- Audio Effects (10) ----
      CataloguePackage(id: 'yossef.denoise', name: 'AI Studio Noise Reduction', nameAr: 'عزل الضوضاء',
          kind: 'audio', category: 'Clean', description: 'Removes hum, hiss, and fan noise.',
          previewGradient: [const Color(0xFF11998E), const Color(0xFF38EF7D)], favourite: true),
      CataloguePackage(id: 'yossef.enhance-voice', name: 'Podcast Voice Enhancer', nameAr: 'تحسين الإذاعي',
          kind: 'audio', category: 'Clean', description: 'Broadcast warmth + presence.',
          previewGradient: [const Color(0xFF00B4DB), const Color(0xFF0083B0)], favourite: true),
      CataloguePackage(id: 'yossef.loudness', name: 'Broadcast Loudness -14 LUFS', nameAr: 'موازنة الصوت',
          kind: 'audio', category: 'Clean', description: 'Normalizes to broadcast standard.',
          previewGradient: [const Color(0xFF56CCF2), const Color(0xFF2F80ED)]),
      CataloguePackage(id: 'yossef.bass', name: 'Sub Bass Boost', nameAr: 'تعزيز الباس',
          kind: 'audio', category: 'Tone', description: 'Deep punchy low-end boost.',
          previewGradient: [const Color(0xFFFF512F), const Color(0xFFDD2476)]),
      CataloguePackage(id: 'yossef.cathedral', name: 'Cathedral Reverb', nameAr: 'صدى القاعة',
          kind: 'audio', category: 'Space', description: 'Lush stereo hall reverb.',
          previewGradient: [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]),
      CataloguePackage(id: 'yossef.echo', name: 'Stereo Delay Echo', nameAr: 'تكرار الصدى',
          kind: 'audio', category: 'Space', description: 'Rhythmic decaying echo.',
          previewGradient: [const Color(0xFF4568DC), const Color(0xFFB06AB3)]),
      CataloguePackage(id: 'yossef.chipmunk', name: 'Chipmunk Pitch', nameAr: 'صوت سنجاب',
          kind: 'audio', category: 'Voice', description: 'High-pitched voice change.',
          previewGradient: [const Color(0xFFF7971E), const Color(0xFFFFD200)]),
      CataloguePackage(id: 'yossef.robot', name: 'Cyber Robot Vocoder', nameAr: 'صوت روبوت',
          kind: 'audio', category: 'Voice', description: 'Metallic robotic synth voice.',
          previewGradient: [const Color(0xFF00C9FF), const Color(0xFF92FE9D)]),
      CataloguePackage(id: 'yossef.telephone', name: 'Telephone EQ', nameAr: 'هاتف',
          kind: 'audio', category: 'Voice', description: 'Lo-fi telephone bandpass.',
          previewGradient: [const Color(0xFF757F9A), const Color(0xFFD7DDE8)]),
      CataloguePackage(id: 'yossef.whisper', name: 'Whisper Boost', nameAr: 'همسة',
          kind: 'audio', category: 'Voice', description: 'ASMR whisper enhancement.',
          previewGradient: [const Color(0xFFB993D6), const Color(0xFF8CA6DB)]),
    ];
  }

  static const List<TextPresetModel> textPresets = [
    TextPresetModel(id: 'default', name: 'YOSSEF Clean Title', sample: 'YOSSEF', color: Colors.white),
    TextPresetModel(id: 'yossef.bold-caption', name: 'Bold TikTok Caption', sample: 'CAPTION',
        color: Color(0xFFCBF53F), strokeWidth: 3.0),
    TextPresetModel(id: 'yossef.block', name: 'Highlight Block', sample: 'BLOCK',
        color: Color(0xFF111111), backgroundColor: Color(0xFFFFE14A)),
    TextPresetModel(id: 'yossef.lower-third', name: 'YOSSEF Lower Third', sample: 'يوسف حامد',
        color: Color(0xFF10160A), backgroundColor: Color(0xFFCBF53F)),
    TextPresetModel(id: 'yossef.neon-cyber', name: 'Neon Cyber Glow', sample: 'CYBER',
        color: Color(0xFF7FFFD4), strokeColor: Color(0xFF005C97), strokeWidth: 2.5),
    TextPresetModel(id: 'yossef.comic', name: 'Comic POW!', sample: 'POW!',
        color: Color(0xFFFFE14A), strokeWidth: 3.5),
    TextPresetModel(id: 'yossef.retro', name: 'Retro Sunset', sample: 'Retro',
        color: Color(0xFFFF6FB5), strokeColor: Color(0xFF3A0B2A), strokeWidth: 2.0),
    TextPresetModel(id: 'yossef.code', name: 'Developer Terminal', sample: 'yossef()',
        color: Color(0xFFE6EDF3), backgroundColor: Color(0xE60D1117)),
  ];

  static List<AiModelItem> buildAiModels() {
    return [
      AiModelItem(id: 'whisper-tiny', family: 'whisper',
          name: 'YOSSEF Whisper Tiny (Multilingual + Arabic)',
          note: 'أسرع تفريغ نصي فوري يدعم العربية و26 لغة',
          sizeText: '78 MB', accuracy: 3, installed: true, active: true),
      AiModelItem(id: 'whisper-base', family: 'whisper', name: 'YOSSEF Whisper Base Pro',
          note: 'توازن مثالي بين السرعة والدقة للتسميات',
          sizeText: '148 MB', accuracy: 4, installed: true),
      AiModelItem(id: 'whisper-small', family: 'whisper', name: 'YOSSEF Whisper Studio Ultra',
          note: 'أعلى دقة تفريغ نصي سينمائي (5/5)',
          sizeText: '488 MB', accuracy: 5),
      AiModelItem(id: 'kokoro-multi-v1', family: 'tts', name: 'YOSSEF Kokoro Neural TTS v1.0',
          note: 'توليد صوت بشري طبيعي متعدد اللغات',
          sizeText: '132 MB', accuracy: 5, installed: true, active: true),
      AiModelItem(id: 'pocket-tts-clone', family: 'tts', name: 'YOSSEF Pocket Voice Cloner',
          note: 'استنساخ أي صوت من عينة 3 ثوانٍ',
          sizeText: '98 MB', accuracy: 5, installed: true),
      AiModelItem(id: 'chatterbox-turbo', family: 'tts', name: 'YOSSEF Chatterbox Turbo',
          note: 'توليد تعليق صوتي تفاعلي مع مشاعر',
          sizeText: '350 MB', accuracy: 5),
      AiModelItem(id: 'rvm-cutout-person', family: 'vision', name: 'YOSSEF Robust Video Matting',
          note: 'عزل خلفية الأشخاص بدقة الشعر',
          sizeText: '15 MB', accuracy: 5, installed: true, active: true),
      AiModelItem(id: 'realesr-8k-upscale', family: 'vision', name: 'YOSSEF Real-ESRGAN x4 (8K)',
          note: 'ترميم ومضاعفة دقة الفيديو إلى 8K',
          sizeText: '5 MB', accuracy: 5, installed: true),
    ];
  }
}

// ============================================================================
// 6. MAIN CONTROLLER
// ============================================================================
class YossefStudioController extends ChangeNotifier {
  bool onStartScreen = true;
  bool forcePhoneMode = false;
  bool isArabic = true;

  YossefThemeData theme = const YossefThemeData();

  String projectName = 'YOSSEF Commercial Cut 8K';
  String projectLocation = '/Users/yossef/Movies/YOSSEF_Projects/Commercial_8K';
  String projectStatus = 'محفوظ تلقائياً ✓';
  int outputWidth = 3840;
  int outputHeight = 2160;
  double frameRate = 60.0;
  String colorSpace = 'Rec.2020 HDR10 (10-bit)';
  int previewQualityIndex = 0;

  bool gpuHardwareAcceleration = true;
  bool magneticTimeline = true;
  bool snapToGrid = true;
  bool smartProxies = true;
  bool playheadStopsAtEnd = true;
  bool vuMetersShown = true;
  bool tenBitHdrPipeline = true;
  bool mcpServerEnabled = true;
  String mcpServerHost = '127.0.0.1';
  int mcpServerPort = 7420;
  String mcpServerToken = 'YOSSEF-PRO-TOKEN-2026';

  double topRowFlex = 0.56;
  double leftColumnFlex = 0.27;
  double centerColumnFlex = 0.45;
  double rightColumnFlex = 0.28;

  List<String> timelineTabs = ['المشهد الرئيسي', 'نسخة ريلز 9:16', 'مؤثرات YOSSEF'];
  int currentTimelineTab = 0;
  TimelineTool activeTool = TimelineTool.select;
  double playhead = 2.4;
  bool isPlaying = false;
  double zoomPixelsPerSecond = 48.0;
  Timer? _playbackTimer;

  String? selectedClipId = 'clip_v1';

  final List<List<TimelineClip>> _undoStack = [];
  final List<List<TimelineClip>> _redoStack = [];

  late List<RecentProjectModel> recentProjects;
  late List<MediaBinItem> mediaBin;
  late List<TimelineTrack> tracks;
  late List<TimelineClip> clips;
  late List<CataloguePackage> packages;
  late List<AiModelItem> aiModels;

  String startSearchQuery = '';
  int startSortIndex = 0;
  String librarySearchQuery = '';
  int activeLibraryTab = 0;
  int activeInspectorTab = 0;

  bool voiceoverRecording = false;
  double voiceoverSeconds = 0.0;
  double voiceoverGainDb = 0.0;
  String teleprompterText =
      'مرحباً بكم في تطبيق استوديو YOSSEF الاحترافي لتحرير الفيديو بأعلى جودة 8K HDR.\nتم تطوير هذا النظام بالكامل بواسطة المطور يوسف حامد - واتساب 01029892573.';

  bool isExporting = false;
  double exportProgress = 0.0;
  int exportCodecIndex = 2;
  int exportResolutionIndex = 3;
  bool exportTenBit = true;
  bool exportHdr = true;
  double exportBitrateMbps = 85.0;

  YossefStudioController() {
    _initData();
  }

  void _initData() {
    packages = YossefCatalogues.buildAllPackages();
    aiModels = YossefCatalogues.buildAiModels();

    recentProjects = [
      const RecentProjectModel(
        path: '/Projects/YOSSEF_Cinema_8K', name: 'إعلان سينمائي YOSSEF 8K HDR',
        detail: '7680 × 4320 · 60 fps · 10-bit HDR', whenText: 'منذ 10 دقائق',
        lengthText: '00:14',
        posterGradient: [Color(0xFF0F2027), Color(0xFF2C5364), Color(0xFFCBF53F)],
      ),
      const RecentProjectModel(
        path: '/Projects/YOSSEF_Reels_Pro', name: 'ريلز احترافي وتأثيرات بصرية',
        detail: '1080 × 1920 · 60 fps · YOSSEF AI', whenText: 'منذ ساعتين',
        lengthText: '00:30',
        posterGradient: [Color(0xFF833AB4), Color(0xFFFD1D1D), Color(0xFFFCB045)],
      ),
      const RecentProjectModel(
        path: '/Projects/YOSSEF_Documentary', name: 'وثائقي الطبيعة',
        detail: '3840 × 2160 · 24 fps · Rec.2020', whenText: 'أمس',
        lengthText: '03:45',
        posterGradient: [Color(0xFF134E5E), Color(0xFF71B280)],
      ),
      const RecentProjectModel(
        path: '/Projects/YOSSEF_Podcast', name: 'حلقة بودكاست مع ترجمة AI',
        detail: '3840 × 2160 · 30 fps · Whisper AI', whenText: 'منذ 3 أيام',
        lengthText: '12:20',
        posterGradient: [Color(0xFF3A1C71), Color(0xFFD76D77), Color(0xFFFFAF7B)],
      ),
    ];

    mediaBin = [
      const MediaBinItem(id: 'm1', name: 'YOSSEF_Drone_Cairo_8K.mp4', kind: ClipKind.video,
          duration: 8.5, format: 'MP4 · HEVC 10-bit', resolution: '7680×4320 · 60fps',
          gradient: [Color(0xFF141E30), Color(0xFF243B55), Color(0xFF3373D1)]),
      const MediaBinItem(id: 'm2', name: 'YOSSEF_Studio_B_Roll_4K.mov', kind: ClipKind.video,
          duration: 6.2, format: 'MOV · ProRes 422 HQ', resolution: '3840×2160 · 120fps',
          gradient: [Color(0xFF3A1C71), Color(0xFFD76D77), Color(0xFFFFAF7B)]),
      const MediaBinItem(id: 'm3', name: 'YOSSEF_Neon_Action_Cut.mp4', kind: ClipKind.video,
          duration: 5.5, format: 'MP4 · AV1 HDR', resolution: '3840×2160 · 60fps',
          gradient: [Color(0xFF005C97), Color(0xFF363795), Color(0xFF00F2FE)]),
      const MediaBinItem(id: 'm4', name: 'YOSSEF_Cinematic_Soundtrack.wav', kind: ClipKind.audio,
          duration: 14.0, format: 'WAV · 96kHz 24-bit', resolution: 'Stereo Master',
          gradient: [Color(0xFF11998E), Color(0xFF38EF7D)]),
      const MediaBinItem(id: 'm5', name: 'YOSSEF_AI_Voiceover_Arabic.wav', kind: ClipKind.audio,
          duration: 6.0, format: 'WAV · Neural TTS', resolution: '48kHz Mono',
          gradient: [Color(0xFF00B09B), Color(0xFF96C93D)]),
      const MediaBinItem(id: 'm6', name: 'YOSSEF_Brand_Overlay_4K.png', kind: ClipKind.image,
          duration: 5.0, format: 'PNG · RGBA 16-bit', resolution: '3840×2160',
          gradient: [Color(0xFF8E2DE2), Color(0xFF4A00E0)]),
    ];

    tracks = [
      TimelineTrack(index: 0, name: 'V3 · العناوين (Titles)', height: 54),
      TimelineTrack(index: 1, name: 'V2 · الألوان (FX & LUTs)', height: 54),
      TimelineTrack(index: 2, name: 'V1 · المسار الرئيسي (Video)', height: 68),
      TimelineTrack(index: 3, name: 'A1 · التعليق (Voiceover)', height: 56),
      TimelineTrack(index: 4, name: 'A2 · الموسيقى (Score)', height: 56),
    ];

    clips = [
      TimelineClip(
        id: 'clip_t1', name: 'عنوان YOSSEF الرئيسي', kind: ClipKind.text, trackIndex: 0,
        startTime: 0.4, duration: 5.2,
        textContent: 'استوديو YOSSEF · المطور يوسف حامد',
        fontSize: 36.0, textColor: const Color(0xFFCBF53F),
        textStrokeColor: Colors.black, textStrokeWidth: 2.5, posY: -0.28,
        keyframes: [
          KeyframePoint(timeOffset: 0.0, value: 0.8, property: 'scale'),
          KeyframePoint(timeOffset: 1.2, value: 1.0, property: 'scale'),
          KeyframePoint(timeOffset: 4.8, value: 1.05, property: 'scale'),
        ],
      ),
      TimelineClip(
        id: 'clip_fx1', name: 'Teal & Orange + Halation', kind: ClipKind.filter,
        trackIndex: 1, startTime: 0.0, duration: 8.5, opacity: 0.9,
        visualChain: [
          AppliedEffect(id: 'yossef.teal-orange', name: 'Teal & Orange', intensity: 85),
          AppliedEffect(id: 'yossef.halation', name: 'Halation Glow', intensity: 65),
        ],
      ),
      TimelineClip(
        id: 'clip_v1', name: 'YOSSEF_Drone_Cairo_8K.mp4', kind: ClipKind.video,
        trackIndex: 2, startTime: 0.0, duration: 5.5,
        contrast: 12.0, saturation: 15.0, vibrance: 20.0, sharpen: 18.0,
        aiEnhanced: true,
        transitionId: 'yossef.whip-pan', transitionName: 'Whip Pan',
        visualChain: [
          AppliedEffect(id: 'yossef.film-grain', name: 'Film Grain', intensity: 35),
          AppliedEffect(id: 'yossef.bloom-pulse', name: 'Bloom Pulse', intensity: 50),
        ],
        keyframes: [
          KeyframePoint(timeOffset: 0.0, value: 1.0, property: 'scale'),
          KeyframePoint(timeOffset: 2.5, value: 1.15, property: 'scale'),
          KeyframePoint(timeOffset: 5.0, value: 1.0, property: 'scale'),
        ],
        previewColors: const [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
      ),
      TimelineClip(
        id: 'clip_v2', name: 'YOSSEF_Studio_B_Roll_4K.mov', kind: ClipKind.video,
        trackIndex: 2, startTime: 5.5, duration: 5.0,
        exposure: 0.3, contrast: 18.0, saturation: 22.0,
        transitionId: 'yossef.zoom-transition', transitionName: 'Hyper Zoom',
        previewColors: const [Color(0xFF3A1C71), Color(0xFFD76D77), Color(0xFFFFAF7B)],
      ),
      TimelineClip(
        id: 'clip_v3', name: 'YOSSEF_Neon_Action_Cut.mp4', kind: ClipKind.video,
        trackIndex: 2, startTime: 10.5, duration: 3.5,
        previewColors: const [Color(0xFF005C97), Color(0xFF363795), Color(0xFF00F2FE)],
      ),
      TimelineClip(
        id: 'clip_a1', name: 'YOSSEF_AI_Voiceover.wav', kind: ClipKind.audio,
        trackIndex: 3, startTime: 0.5, duration: 6.0,
        volume: 1.15, denoise: true, enhanceVoice: true, normalizeLoudness: true,
      ),
      TimelineClip(
        id: 'clip_a2', name: 'YOSSEF_Soundtrack.wav', kind: ClipKind.audio,
        trackIndex: 4, startTime: 0.0, duration: 14.0,
        volume: 0.85, fadeIn: 1.0, fadeOut: 1.5,
      ),
    ];
  }

  String tr(String key) => YossefI18n.t(key, isArabic);

  double get timelineDuration {
    if (clips.isEmpty) return 15.0;
    double maxEnd = 10.0;
    for (final c in clips) {
      if (c.endTime > maxEnd) maxEnd = c.endTime;
    }
    return maxEnd + 2.0;
  }

  TimelineClip? get selectedClip {
    if (selectedClipId == null) return null;
    for (final c in clips) {
      if (c.id == selectedClipId) return c;
    }
    return null;
  }

  List<TimelineClip> get activeClipsAtPlayhead {
    final active = <TimelineClip>[];
    for (final c in clips) {
      TimelineTrack? track;
      for (final t in tracks) {
        if (t.index == c.trackIndex) { track = t; break; }
      }
      if (track != null && !track.visible) continue;
      if (playhead >= c.startTime && playhead <= c.endTime) active.add(c);
    }
    active.sort((a, b) => b.trackIndex.compareTo(a.trackIndex));
    return active;
  }

  bool get canUndo => _undoStack.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;

  void _saveHistory() {
    _undoStack.add(clips.map((c) => c.clone()).toList());
    if (_undoStack.length > 40) _undoStack.removeAt(0);
    _redoStack.clear();
  }

  void undo() {
    if (_undoStack.isEmpty) return;
    _redoStack.add(clips.map((c) => c.clone()).toList());
    clips = _undoStack.removeLast();
    _validateSelection();
    notifyListeners();
  }

  void redo() {
    if (_redoStack.isEmpty) return;
    _undoStack.add(clips.map((c) => c.clone()).toList());
    clips = _redoStack.removeLast();
    _validateSelection();
    notifyListeners();
  }

  void _validateSelection() {
    if (selectedClipId != null && !clips.any((c) => c.id == selectedClipId)) {
      selectedClipId = clips.isNotEmpty ? clips.first.id : null;
    }
  }

  void togglePlay() {
    isPlaying = !isPlaying;
    _playbackTimer?.cancel();
    if (isPlaying) {
      _playbackTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
        playhead += 1.0 / frameRate;
        final maxDur = timelineDuration - 2.0;
        if (playhead >= maxDur) {
          if (playheadStopsAtEnd) {
            playhead = maxDur;
            isPlaying = false;
            _playbackTimer?.cancel();
          } else {
            playhead = 0.0;
          }
        }
        notifyListeners();
      });
    }
    notifyListeners();
  }

  void stop() {
    isPlaying = false;
    _playbackTimer?.cancel();
    notifyListeners();
  }

  void seek(double seconds) {
    playhead = seconds.clamp(0.0, timelineDuration);
    notifyListeners();
  }

  void stepFrames(int deltaFrames) {
    seek(playhead + deltaFrames / frameRate);
  }

  void selectClip(String? id) {
    selectedClipId = id;
    notifyListeners();
  }

  void splitSelectedOrAtPlayhead() {
    TimelineClip? target = selectedClip;
    if (target == null || playhead <= target.startTime + 0.1 || playhead >= target.endTime - 0.1) {
      for (final c in clips) {
        if (playhead > c.startTime + 0.15 && playhead < c.endTime - 0.15) {
          target = c;
          break;
        }
      }
    }
    if (target == null) return;
    if (playhead <= target.startTime + 0.1 || playhead >= target.endTime - 0.1) return;

    _saveHistory();
    final splitPoint = playhead;
    final firstDuration = splitPoint - target.startTime;
    final secondDuration = target.endTime - splitPoint;

    target.duration = firstDuration;
    final secondClip = target.clone(newId: 'clip_${DateTime.now().microsecondsSinceEpoch}');
    secondClip.name = '${target.name} (2)';
    secondClip.startTime = splitPoint;
    secondClip.duration = secondDuration;
    secondClip.sourceOffset = target.sourceOffset + firstDuration;

    clips.add(secondClip);
    selectedClipId = secondClip.id;
    notifyListeners();
  }

  void deleteSelectedClip() {
    final target = selectedClip;
    if (target == null) return;
    _saveHistory();
    final trackIdx = target.trackIndex;
    final start = target.startTime;
    final dur = target.duration;
    clips.removeWhere((c) => c.id == target.id);
    if (magneticTimeline) {
      for (final c in clips) {
        if (c.trackIndex == trackIdx && c.startTime > start) {
          c.startTime = math.max(0.0, c.startTime - dur);
        }
      }
    }
    selectedClipId = clips.isNotEmpty ? clips.first.id : null;
    notifyListeners();
  }

  void duplicateSelectedClip() {
    final target = selectedClip;
    if (target == null) return;
    _saveHistory();
    final copy = target.clone(newId: 'clip_${DateTime.now().microsecondsSinceEpoch}');
    copy.name = '${target.name} (نسخة)';
    copy.startTime = target.endTime;
    clips.add(copy);
    selectedClipId = copy.id;
    notifyListeners();
  }

  void freezeFrameSelectedClip() {
    final target = selectedClip;
    if (target == null) return;
    _saveHistory();
    final freeze = TimelineClip(
      id: 'freeze_${DateTime.now().microsecondsSinceEpoch}',
      name: 'إطار مجمد - ${target.name}',
      kind: ClipKind.image, trackIndex: target.trackIndex,
      startTime: playhead, duration: 2.5,
      previewColors: List<Color>.from(target.previewColors),
    );
    clips.add(freeze);
    selectedClipId = freeze.id;
    notifyListeners();
  }

  void reverseSelectedClip() {
    final target = selectedClip;
    if (target == null) return;
    _saveHistory();
    target.previewColors = target.previewColors.reversed.toList();
    if (!target.name.contains('⟲')) target.name = '${target.name} ⟲';
    notifyListeners();
  }

  void mirrorSelectedClip() {
    final target = selectedClip;
    if (target == null) return;
    _saveHistory();
    target.flipH = !target.flipH;
    notifyListeners();
  }

  void rotateSelectedClip() {
    final target = selectedClip;
    if (target == null) return;
    _saveHistory();
    target.rotation = ((target.rotation + 90.0) % 360.0);
    if (target.rotation > 180.0) target.rotation -= 360.0;
    notifyListeners();
  }

  void addMediaFromBin(MediaBinItem item) {
    _saveHistory();
    final int targetTrack = item.kind == ClipKind.audio ? 3 : (item.kind == ClipKind.image ? 1 : 2);
    final newClip = TimelineClip(
      id: 'clip_${DateTime.now().microsecondsSinceEpoch}',
      name: item.name, kind: item.kind, trackIndex: targetTrack,
      startTime: playhead, duration: item.duration,
      previewColors: List<Color>.from(item.gradient),
    );
    clips.add(newClip);
    selectedClipId = newClip.id;
    notifyListeners();
  }

  void addTextFromPreset(TextPresetModel preset) {
    _saveHistory();
    final newClip = TimelineClip(
      id: 'title_${DateTime.now().microsecondsSinceEpoch}',
      name: preset.name, kind: ClipKind.text, trackIndex: 0,
      startTime: playhead, duration: 4.0,
      textContent: preset.id == 'yossef.lower-third'
          ? 'المطور: يوسف حامد · واتساب 01029892573'
          : '${preset.sample} · YOSSEF',
      fontSize: 40.0, textColor: preset.color,
      textBackgroundPlate: preset.backgroundColor,
      textStrokeColor: preset.strokeColor, textStrokeWidth: preset.strokeWidth,
    );
    clips.add(newClip);
    selectedClipId = newClip.id;
    notifyListeners();
  }

  void addShapeClip(String shapeType, String label, Color color) {
    _saveHistory();
    final newClip = TimelineClip(
      id: 'shape_${DateTime.now().microsecondsSinceEpoch}',
      name: label, kind: ClipKind.shape, trackIndex: 0,
      startTime: playhead, duration: 4.0,
      shapeType: shapeType, shapeColor: color, scale: 0.55,
    );
    clips.add(newClip);
    selectedClipId = newClip.id;
    notifyListeners();
  }

  void applyPackageToSelection(CataloguePackage pkg) {
    _saveHistory();
    TimelineClip? target = selectedClip;
    if (pkg.kind == 'filter' && target == null) {
      final layer = TimelineClip(
        id: 'filter_${DateTime.now().microsecondsSinceEpoch}',
        name: isArabic ? pkg.nameAr : pkg.name, kind: ClipKind.filter,
        trackIndex: 1, startTime: playhead, duration: 5.0,
        visualChain: [AppliedEffect(id: pkg.id, name: isArabic ? pkg.nameAr : pkg.name, intensity: 85)],
        previewColors: List<Color>.from(pkg.previewGradient),
      );
      clips.add(layer);
      selectedClipId = layer.id;
      notifyListeners();
      return;
    }

    target ??= clips.isNotEmpty ? clips.first : null;
    if (target == null) return;

    if (pkg.kind == 'transition') {
      target.transitionId = pkg.id;
      target.transitionName = isArabic ? pkg.nameAr : pkg.name;
    } else if (pkg.kind == 'audio') {
      target.audioChain.add(AppliedEffect(id: pkg.id, name: isArabic ? pkg.nameAr : pkg.name));
    } else {
      target.visualChain.add(AppliedEffect(id: pkg.id, name: isArabic ? pkg.nameAr : pkg.name));
    }
    notifyListeners();
  }

  void addAdjustmentLayer() {
    _saveHistory();
    final layer = TimelineClip(
      id: 'adj_${DateTime.now().microsecondsSinceEpoch}',
      name: isArabic ? 'طبقة ألوان YOSSEF HDR' : 'YOSSEF Adjustment Layer',
      kind: ClipKind.filter, trackIndex: 1,
      startTime: playhead, duration: 6.0,
      contrast: 15.0, saturation: 18.0, vibrance: 25.0,
      visualChain: [AppliedEffect(id: 'yossef.teal-orange', name: 'Teal & Orange', intensity: 75)],
    );
    clips.add(layer);
    selectedClipId = layer.id;
    notifyListeners();
  }

  void addKeyframeToSelected(String property, double normalizedValue) {
    final target = selectedClip;
    if (target == null) return;
    _saveHistory();
    final localTime = (playhead - target.startTime).clamp(0.0, target.duration);
    target.keyframes.removeWhere(
        (k) => k.property == property && (k.timeOffset - localTime).abs() < 0.08);
    target.keyframes.add(KeyframePoint(
      timeOffset: localTime,
      value: normalizedValue.clamp(0.0, 1.0),
      property: property,
    ));
    target.keyframes.sort((a, b) => a.timeOffset.compareTo(b.timeOffset));
    notifyListeners();
  }

  void removeKeyframe(String property, double localTime) {
    final target = selectedClip;
    if (target == null) return;
    _saveHistory();
    target.keyframes.removeWhere(
        (k) => k.property == property && (k.timeOffset - localTime).abs() < 0.08);
    notifyListeners();
  }

  void generateAutoCaptions(String customScript) {
    _saveHistory();
    final phrases = customScript.trim().isNotEmpty
        ? customScript.split('\n').where((s) => s.trim().isNotEmpty).toList()
        : [
            'مرحباً بكم في استوديو YOSSEF الاحترافي',
            'أقوى محرر فيديو بالذكاء الاصطناعي بدقة 8K HDR',
            'تم التطوير بحقوق YOSSEF - المطور يوسف حامد',
            'للتواصل واتساب: 01029892573',
          ];

    double cursor = playhead;
    for (int i = 0; i < phrases.length; i++) {
      final cap = TimelineClip(
        id: 'cap_${DateTime.now().microsecondsSinceEpoch}_$i',
        name: 'ترجمة AI #${i + 1}',
        kind: ClipKind.text, trackIndex: 0,
        startTime: cursor, duration: 2.6,
        textContent: phrases[i], fontSize: 34.0,
        textColor: const Color(0xFFCBF53F),
        textStrokeColor: Colors.black, textStrokeWidth: 2.5,
        textBackgroundPlate: const Color(0xAA000000), posY: 0.34,
      );
      clips.add(cap);
      cursor += 2.7;
    }
    notifyListeners();
  }

  void generateSpeechClip(String scriptText, String voiceName) {
    _saveHistory();
    final ttsClip = TimelineClip(
      id: 'tts_${DateTime.now().microsecondsSinceEpoch}',
      name: 'صوت ذكي ($voiceName)', kind: ClipKind.audio, trackIndex: 3,
      startTime: playhead,
      duration: math.max(3.0, scriptText.length * 0.08),
      volume: 1.2, enhanceVoice: true, normalizeLoudness: true,
    );
    clips.add(ttsClip);
    selectedClipId = ttsClip.id;
    notifyListeners();
  }

  void notifyUpdate() => notifyListeners();

  @override
  void dispose() {
    _playbackTimer?.cancel();
    super.dispose();
  }
}

// ============================================================================
// 7. ROOT APP
// ============================================================================
class YossefStudioApp extends StatefulWidget {
  const YossefStudioApp({super.key});
  @override
  State<YossefStudioApp> createState() => _YossefStudioAppState();
}

class _YossefStudioAppState extends State<YossefStudioApp> {
  final YossefStudioController controller = YossefStudioController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.theme;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: YossefBrand.appName,
          theme: ThemeData(
            brightness: t.dark ? Brightness.dark : Brightness.light,
            scaffoldBackgroundColor: t.page,
            primaryColor: t.accent,
            colorScheme: ColorScheme(
              brightness: t.dark ? Brightness.dark : Brightness.light,
              primary: t.accent, onPrimary: t.onAccent,
              secondary: t.accentHover, onSecondary: t.onAccent,
              error: t.danger, onError: Colors.white,
              surface: t.panel, onSurface: t.fg,
            ),
            fontFamily: 'Roboto',
            useMaterial3: true,
          ),
          builder: (context, child) {
            return Directionality(
              textDirection: controller.isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(t.textScaleFactor),
                ),
                child: child!,
              ),
            );
          },
          home: YossefMainWindow(controller: controller),
        );
      },
    );
  }
}

// ============================================================================
// 8. MAIN WINDOW
// ============================================================================
class YossefMainWindow extends StatefulWidget {
  final YossefStudioController controller;
  const YossefMainWindow({super.key, required this.controller});
  @override
  State<YossefMainWindow> createState() => _YossefMainWindowState();
}

class _YossefMainWindowState extends State<YossefMainWindow> {
  final FocusNode _keyboardFocus = FocusNode();
  YossefStudioController get c => widget.controller;
  YossefThemeData get t => c.theme;

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    final key = event.logicalKey;
    final isCtrl = HardwareKeyboard.instance.isControlPressed ||
        HardwareKeyboard.instance.isMetaPressed;

    if (key == LogicalKeyboardKey.space && !c.onStartScreen) {
      c.togglePlay();
    } else if (key == LogicalKeyboardKey.keyS && !isCtrl && !c.onStartScreen) {
      c.splitSelectedOrAtPlayhead();
    } else if ((key == LogicalKeyboardKey.delete || key == LogicalKeyboardKey.backspace) &&
        !c.onStartScreen) {
      c.deleteSelectedClip();
    } else if (key == LogicalKeyboardKey.keyZ && isCtrl) {
      if (HardwareKeyboard.instance.isShiftPressed) c.redo();
      else c.undo();
    } else if (key == LogicalKeyboardKey.keyD && isCtrl && !c.onStartScreen) {
      c.duplicateSelectedClip();
    } else if (key == LogicalKeyboardKey.arrowLeft && !c.onStartScreen) {
      c.stepFrames(-1);
    } else if (key == LogicalKeyboardKey.arrowRight && !c.onStartScreen) {
      c.stepFrames(1);
    } else if (key == LogicalKeyboardKey.keyK && !c.onStartScreen) {
      c.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final isPhoneLayout = c.forcePhoneMode || screenW < 760;

    return KeyboardListener(
      focusNode: _keyboardFocus,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: c.onStartScreen ? t.launchPage : t.page,
        body: SafeArea(
          child: Column(
            children: [
              YossefTitleBar(
                controller: c, isPhoneLayout: isPhoneLayout,
                onOpenSettings: ({int initialTab = 0}) => _showSettingsDialog(context, initialTab),
                onOpenDeveloperSettings: () => _showSettingsDialog(context, 7),
                onOpenNewProject: () => _showNewProjectDialog(context),
                onOpenExport: () => _showExportDialog(context),
                onOpenCaptions: () => _showCaptionsDialog(context),
                onOpenSpeech: () => _showSpeechDialog(context),
                onOpenVoiceover: () => _showVoiceoverDialog(context),
              ),
              Expanded(
                child: c.onStartScreen
                    ? YossefStartScreen(
                        controller: c, isPhoneLayout: isPhoneLayout,
                        onCreateNew: () => _showNewProjectDialog(context),
                        onOpenSettings: ({int initialTab = 0}) => _showSettingsDialog(context, initialTab),
                      )
                    : isPhoneLayout
                        ? YossefPhoneEditor(
                            controller: c,
                            onOpenSettings: ({int initialTab = 0}) => _showSettingsDialog(context, initialTab),
                            onOpenExport: () => _showExportDialog(context),
                            onOpenCaptions: () => _showCaptionsDialog(context),
                            onOpenSpeech: () => _showSpeechDialog(context),
                            onOpenVoiceover: () => _showVoiceoverDialog(context),
                          )
                        : YossefDesktopWorkspace(
                            controller: c,
                            onOpenSettings: ({int initialTab = 0}) => _showSettingsDialog(context, initialTab),
                            onOpenExport: () => _showExportDialog(context),
                            onOpenCaptions: () => _showCaptionsDialog(context),
                            onOpenSpeech: () => _showSpeechDialog(context),
                            onOpenVoiceover: () => _showVoiceoverDialog(context),
                          ),
              ),
              _buildFooterStrip(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterStrip(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: t.launchWell,
        border: Border(top: BorderSide(color: t.line, width: 1)),
      ),
      child: Row(
        children: [
          Container(width: 8, height: 8,
              decoration: BoxDecoration(color: t.accent, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(
            '${YossefBrand.shortName} ULTRA v3.0 · ${c.outputWidth}×${c.outputHeight} · ${c.frameRate.toInt()} FPS · ${c.colorSpace}',
            style: TextStyle(color: t.fgMuted, fontSize: 11, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          InkWell(
            onTap: () => _showSettingsDialog(context, 7),
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified_user, size: 13, color: t.accent),
                  const SizedBox(width: 4),
                  Text(
                    'حقوق YOSSEF · يوسف حامد · واتساب: 01029892573',
                    style: TextStyle(color: t.accent, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context, int initialTab) {
    showDialog(context: context, builder: (_) =>
        YossefSettingsDialog(controller: c, initialTab: initialTab));
  }

  void _showNewProjectDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => YossefNewProjectDialog(controller: c));
  }

  void _showExportDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => YossefExportDialog(controller: c));
  }

  void _showCaptionsDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => YossefCaptionsDialog(controller: c));
  }

  void _showSpeechDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => YossefSpeechDialog(controller: c));
  }

  void _showVoiceoverDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => YossefVoiceoverDialog(controller: c));
  }
}

// ============================================================================
// 9. TITLE BAR
// ============================================================================
class YossefTitleBar extends StatelessWidget {
  final YossefStudioController controller;
  final bool isPhoneLayout;
  final void Function({int initialTab}) onOpenSettings;
  final VoidCallback onOpenDeveloperSettings;
  final VoidCallback onOpenNewProject;
  final VoidCallback onOpenExport;
  final VoidCallback onOpenCaptions;
  final VoidCallback onOpenSpeech;
  final VoidCallback onOpenVoiceover;

  const YossefTitleBar({
    super.key, required this.controller, required this.isPhoneLayout,
    required this.onOpenSettings, required this.onOpenDeveloperSettings,
    required this.onOpenNewProject, required this.onOpenExport,
    required this.onOpenCaptions, required this.onOpenSpeech,
    required this.onOpenVoiceover,
  });

  @override
  Widget build(BuildContext context) {
    final t = controller.theme;
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: controller.onStartScreen ? t.launchPanel : t.panel,
        border: Border(bottom: BorderSide(color: t.line, width: 1)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              controller.onStartScreen = !controller.onStartScreen;
              controller.notifyUpdate();
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [t.accent, t.accentHover]),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.movie_filter_rounded, size: 16, color: t.onAccent),
                  const SizedBox(width: 6),
                  Text('YOSSEF',
                      style: TextStyle(color: t.onAccent, fontWeight: FontWeight.w900,
                          fontSize: 13, letterSpacing: 0.8)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (!isPhoneLayout) ...[
            _buildFileMenu(context),
            _buildEditMenu(context),
            _buildAiMenu(context),
            _buildViewMenu(context),
          ],
          const Spacer(),
          if (!controller.onStartScreen && !isPhoneLayout)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: t.field,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: t.line),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.folder_special_outlined, size: 14, color: t.accent),
                  const SizedBox(width: 6),
                  Text(controller.projectName,
                      style: TextStyle(color: t.fg, fontWeight: FontWeight.w600, fontSize: 12)),
                  const SizedBox(width: 8),
                  Text('· ${controller.projectStatus}',
                      style: TextStyle(color: t.green, fontSize: 11)),
                ],
              ),
            ),
          const Spacer(),
          IconButton(
            tooltip: controller.isArabic ? 'Switch to English' : 'التحويل للعربية',
            onPressed: () {
              controller.isArabic = !controller.isArabic;
              controller.notifyUpdate();
            },
            icon: Icon(Icons.language, size: 18, color: t.fgMuted),
          ),
          IconButton(
            tooltip: controller.forcePhoneMode ? 'Desktop Mode' : 'Phone Mode',
            onPressed: () {
              controller.forcePhoneMode = !controller.forcePhoneMode;
              controller.notifyUpdate();
            },
            icon: Icon(
              controller.forcePhoneMode ? Icons.desktop_windows_outlined : Icons.smartphone_rounded,
              size: 18, color: t.fgMuted,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: t.fg, backgroundColor: t.field,
                side: BorderSide(color: t.accent.withOpacity(0.6)),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                minimumSize: const Size(0, 32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => onOpenSettings(initialTab: 7),
              icon: Icon(Icons.settings_suggest_rounded, size: 16, color: t.accent),
              label: Text(controller.tr('common.settings'),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
          if (!controller.onStartScreen)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: t.accent, foregroundColor: t.onAccent,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                minimumSize: const Size(0, 32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: onOpenExport,
              icon: const Icon(Icons.ios_share_rounded, size: 15),
              label: Text(controller.tr('common.export'),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildFileMenu(BuildContext context) {
    final t = controller.theme;
    return PopupMenuButton<String>(
      tooltip: controller.isArabic ? 'ملف' : 'File',
      color: t.raised,
      onSelected: (value) {
        switch (value) {
          case 'new': onOpenNewProject(); break;
          case 'open':
            controller.onStartScreen = false;
            controller.notifyUpdate();
            break;
          case 'export': onOpenExport(); break;
          case 'home':
            controller.onStartScreen = true;
            controller.notifyUpdate();
            break;
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(value: 'new', child: Text(controller.tr('start.newProject'))),
        PopupMenuItem(value: 'open', child: Text(controller.tr('start.openProject'))),
        PopupMenuItem(value: 'export', child: Text(controller.tr('common.export'))),
        const PopupMenuDivider(),
        PopupMenuItem(value: 'home', child: Text(controller.isArabic ? 'العودة للرئيسية' : 'Back to Home')),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(controller.isArabic ? 'ملف' : 'File',
            style: TextStyle(color: t.fgMuted, fontSize: 12, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildEditMenu(BuildContext context) {
    final t = controller.theme;
    return PopupMenuButton<String>(
      tooltip: controller.isArabic ? 'تحرير' : 'Edit',
      color: t.raised,
      onSelected: (value) {
        switch (value) {
          case 'undo': controller.undo(); break;
          case 'redo': controller.redo(); break;
          case 'split': controller.splitSelectedOrAtPlayhead(); break;
          case 'duplicate': controller.duplicateSelectedClip(); break;
          case 'delete': controller.deleteSelectedClip(); break;
          case 'freeze': controller.freezeFrameSelectedClip(); break;
          case 'reverse': controller.reverseSelectedClip(); break;
          case 'mirror': controller.mirrorSelectedClip(); break;
          case 'rotate': controller.rotateSelectedClip(); break;
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(value: 'undo', child: Text(controller.isArabic ? 'تراجع (Ctrl+Z)' : 'Undo (Ctrl+Z)')),
        PopupMenuItem(value: 'redo', child: Text(controller.isArabic ? 'إعادة (Ctrl+Shift+Z)' : 'Redo')),
        const PopupMenuDivider(),
        PopupMenuItem(value: 'split', child: Text(controller.tr('common.split'))),
        PopupMenuItem(value: 'duplicate', child: Text(controller.tr('common.duplicate'))),
        PopupMenuItem(value: 'delete', child: Text(controller.tr('common.delete'))),
        const PopupMenuDivider(),
        PopupMenuItem(value: 'freeze', child: Text(controller.tr('common.freeze'))),
        PopupMenuItem(value: 'reverse', child: Text(controller.tr('common.reverse'))),
        PopupMenuItem(value: 'mirror', child: Text(controller.tr('common.mirror'))),
        PopupMenuItem(value: 'rotate', child: Text(controller.tr('common.rotate'))),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(controller.isArabic ? 'تحرير' : 'Edit',
            style: TextStyle(color: t.fgMuted, fontSize: 12, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildAiMenu(BuildContext context) {
    final t = controller.theme;
    return PopupMenuButton<String>(
      tooltip: 'YOSSEF AI',
      color: t.raised,
      onSelected: (value) {
        switch (value) {
          case 'captions': onOpenCaptions(); break;
          case 'speech': onOpenSpeech(); break;
          case 'voiceover': onOpenVoiceover(); break;
          case 'models': onOpenSettings(initialTab: 2); break;
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(value: 'captions', child: Text(controller.tr('common.captions'))),
        PopupMenuItem(value: 'speech', child: Text(controller.tr('common.speech'))),
        PopupMenuItem(value: 'voiceover', child: Text(controller.tr('common.voiceover'))),
        const PopupMenuDivider(),
        PopupMenuItem(value: 'models', child: Text(controller.isArabic ? 'إدارة النماذج' : 'AI Models')),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(controller.isArabic ? 'AI' : 'YOSSEF AI',
            style: TextStyle(color: t.accent, fontSize: 12, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildViewMenu(BuildContext context) {
    final t = controller.theme;
    return PopupMenuButton<String>(
      tooltip: 'View',
      color: t.raised,
      onSelected: (value) {
        switch (value) {
          case 'zoom-in':
            controller.zoomPixelsPerSecond = (controller.zoomPixelsPerSecond * 1.25).clamp(20.0, 200.0);
            controller.notifyUpdate();
            break;
          case 'zoom-out':
            controller.zoomPixelsPerSecond = (controller.zoomPixelsPerSecond / 1.25).clamp(20.0, 200.0);
            controller.notifyUpdate();
            break;
          case 'phone':
            controller.forcePhoneMode = !controller.forcePhoneMode;
            controller.notifyUpdate();
            break;
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(value: 'zoom-in', child: Text(controller.isArabic ? 'تكبير المخطط' : 'Zoom In Timeline')),
        PopupMenuItem(value: 'zoom-out', child: Text(controller.isArabic ? 'تصغير المخطط' : 'Zoom Out Timeline')),
        PopupMenuItem(value: 'phone', child: Text(controller.isArabic ? 'وضع الهاتف' : 'Phone Mode')),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(controller.isArabic ? 'عرض' : 'View',
            style: TextStyle(color: t.fgMuted, fontSize: 12, fontWeight: FontWeight.w500)),
      ),
    );
  }
}

// ============================================================================
// 10. START SCREEN
// ============================================================================
class YossefStartScreen extends StatelessWidget {
  final YossefStudioController controller;
  final bool isPhoneLayout;
  final VoidCallback onCreateNew;
  final void Function({int initialTab}) onOpenSettings;

  const YossefStartScreen({
    super.key, required this.controller, required this.isPhoneLayout,
    required this.onCreateNew, required this.onOpenSettings,
  });

  @override
  Widget build(BuildContext context) {
    final t = controller.theme;
    final filteredProjects = controller.recentProjects.where((p) {
      if (controller.startSearchQuery.trim().isEmpty) return true;
      return p.name.toLowerCase().contains(controller.startSearchQuery.toLowerCase());
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isPhoneLayout ? 16 : 48,
        vertical: isPhoneLayout ? 20 : 36,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1320),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHero(context),
              const SizedBox(height: 24),
              _buildActionRow(context),
              const SizedBox(height: 32),
              _buildRecentHeader(context, filteredProjects.length),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredProjects.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: isPhoneLayout ? 420 : 320,
                  mainAxisExtent: 215,
                  crossAxisSpacing: 16, mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) => _buildProjectCard(context, filteredProjects[index]),
              ),
              const SizedBox(height: 36),
              _buildLearnSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final t = controller.theme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [t.launchPanel, t.accent.withOpacity(0.12), t.launchRaised],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: t.accent.withOpacity(0.4), width: 1.2),
      ),
      child: Wrap(
        spacing: 20, runSpacing: 16,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: t.accent, borderRadius: BorderRadius.circular(20)),
                    child: Text('YOSSEF OFFICIAL · 8K HDR',
                        style: TextStyle(color: t.onAccent, fontSize: 11, fontWeight: FontWeight.w900)),
                  ),
                  const SizedBox(width: 10),
                  Text(YossefBrand.version, style: TextStyle(color: t.fgMuted, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                controller.tr('start.welcomeBack'),
                style: TextStyle(color: t.fg, fontSize: isPhoneLayout ? 24 : 32,
                    fontWeight: FontWeight.w900, letterSpacing: -0.5),
              ),
              const SizedBox(height: 6),
              Text(controller.tr('start.welcomeNote'),
                  style: TextStyle(color: t.fgMuted, fontSize: 14)),
            ],
          ),
          InkWell(
            onTap: () => onOpenSettings(initialTab: 7),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: t.launchField,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: t.accent),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified_rounded, color: t.accent, size: 18),
                      const SizedBox(width: 6),
                      Text('المطور: يوسف حامد',
                          style: TextStyle(color: t.fg, fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.chat_bubble_outline_rounded, color: t.green, size: 15),
                      const SizedBox(width: 6),
                      Text('واتساب: ${YossefBrand.whatsappNumber}',
                          style: TextStyle(color: t.green, fontWeight: FontWeight.w700, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(BuildContext context) {
    return Wrap(
      spacing: 14, runSpacing: 14,
      children: [
        _buildActionTile(context, primary: true,
            icon: Icons.add_circle_outline_rounded,
            title: controller.tr('start.newProject'),
            subtitle: controller.tr('start.newProjectNote'),
            width: isPhoneLayout ? double.infinity : 360, onTap: onCreateNew),
        _buildActionTile(context, primary: false,
            icon: Icons.play_circle_fill_rounded,
            title: controller.isArabic ? 'فتح المحرر الآن' : 'Launch Full Editor',
            subtitle: controller.isArabic ? 'الدخول المباشر للمشروع' : 'Jump into active project',
            width: isPhoneLayout ? double.infinity : 340,
            onTap: () {
              controller.onStartScreen = false;
              controller.notifyUpdate();
            }),
        _buildActionTile(context, primary: false,
            icon: Icons.settings_applications_rounded,
            title: controller.isArabic ? 'الضبط والمطور' : 'Settings & Developer',
            subtitle: 'YOSSEF · واتساب 01029892573',
            width: isPhoneLayout ? double.infinity : 340,
            onTap: () => onOpenSettings(initialTab: 7)),
      ],
    );
  }

  Widget _buildActionTile(BuildContext context, {
    required bool primary, required IconData icon,
    required String title, required String subtitle,
    required double width, required VoidCallback onTap,
  }) {
    final t = controller.theme;
    final bg = primary ? t.accent : t.launchPanel;
    final fg = primary ? t.onAccent : t.fg;
    final subFg = primary ? t.onAccent.withOpacity(0.78) : t.fgMuted;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: primary ? null : Border.all(color: t.lineStrong),
        ),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: primary ? fg.withOpacity(0.14) : t.launchField,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: fg, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: fg, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: subFg, fontSize: 12),
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentHeader(BuildContext context, int count) {
    final t = controller.theme;
    return Row(
      children: [
        Text(controller.tr('start.recentProjects'),
            style: TextStyle(color: t.fg, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(color: t.launchField, borderRadius: BorderRadius.circular(12)),
          child: Text('$count', style: TextStyle(color: t.fgMuted, fontSize: 12)),
        ),
        const Spacer(),
        SizedBox(
          width: isPhoneLayout ? 160 : 260,
          height: 34,
          child: TextField(
            onChanged: (v) {
              controller.startSearchQuery = v;
              controller.notifyUpdate();
            },
            style: TextStyle(color: t.fg, fontSize: 13),
            decoration: InputDecoration(
              hintText: controller.tr('start.searchProjects'),
              hintStyle: TextStyle(color: t.fgDim, fontSize: 12),
              prefixIcon: Icon(Icons.search, size: 16, color: t.fgDim),
              filled: true, fillColor: t.launchPanel,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: t.line),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard(BuildContext context, RecentProjectModel proj) {
    final t = controller.theme;
    return InkWell(
      onTap: () {
        controller.projectName = proj.name;
        controller.onStartScreen = false;
        controller.notifyUpdate();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: t.launchPanel,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: t.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: proj.posterGradient,
                      begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(Icons.play_circle_outline_rounded,
                          size: 38, color: Colors.white.withOpacity(0.85)),
                    ),
                    Positioned(
                      top: 8, left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('YOSSEF PRO',
                            style: TextStyle(color: Color(0xFFCBF53F), fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Positioned(
                      bottom: 8, right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(proj.lengthText,
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(proj.name, style: TextStyle(color: t.fg, fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text('${proj.whenText} · ${proj.detail}',
                  style: TextStyle(color: t.fgDim, fontSize: 11),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearnSection(BuildContext context) {
    final t = controller.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(controller.tr('start.learnAndCommunity'),
            style: TextStyle(color: t.fg, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        Wrap(
          spacing: 14, runSpacing: 14,
          children: [
            _buildLearnCard(context, icon: Icons.verified_user_rounded,
                title: controller.tr('start.developerCardTitle'),
                note: controller.tr('start.developerCardNote'),
                highlight: true, onTap: () => onOpenSettings(initialTab: 7)),
            _buildLearnCard(context, icon: Icons.keyboard_alt_outlined,
                title: controller.tr('start.keyboardShortcuts'),
                note: controller.tr('start.keyboardShortcutsNote'),
                onTap: () => onOpenSettings(initialTab: 6)),
            _buildLearnCard(context, icon: Icons.psychology_rounded,
                title: controller.isArabic ? 'نماذج الذكاء الاصطناعي' : 'Local AI Models',
                note: controller.isArabic ? 'Whisper · TTS · RVM · 8K Upscaler' : 'Whisper, TTS, RVM, 8K Upscaler',
                onTap: () => onOpenSettings(initialTab: 2)),
            _buildLearnCard(context, icon: Icons.hub_outlined,
                title: controller.isArabic ? 'خادم الأتمتة MCP' : 'MCP Automation Server',
                note: '${controller.mcpServerHost}:${controller.mcpServerPort}',
                onTap: () => onOpenSettings(initialTab: 5)),
          ],
        ),
      ],
    );
  }

  Widget _buildLearnCard(BuildContext context, {
    required IconData icon, required String title, required String note,
    bool highlight = false, required VoidCallback onTap,
  }) {
    final t = controller.theme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: isPhoneLayout ? double.infinity : 305,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: highlight ? t.accentSoft : t.launchPanel,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: highlight ? t.accent : t.line),
        ),
        child: Row(
          children: [
            Container(
              width: 38, height: 38,
              decoration: BoxDecoration(
                color: highlight ? t.accent : t.launchField,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 20, color: highlight ? t.onAccent : t.fg),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: t.fg, fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(note, style: TextStyle(color: t.fgMuted, fontSize: 11)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 13, color: t.fgDim),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 11. DESKTOP WORKSPACE
// ============================================================================
class YossefDesktopWorkspace extends StatefulWidget {
  final YossefStudioController controller;
  final void Function({int initialTab}) onOpenSettings;
  final VoidCallback onOpenExport;
  final VoidCallback onOpenCaptions;
  final VoidCallback onOpenSpeech;
  final VoidCallback onOpenVoiceover;

  const YossefDesktopWorkspace({
    super.key, required this.controller,
    required this.onOpenSettings, required this.onOpenExport,
    required this.onOpenCaptions, required this.onOpenSpeech, required this.onOpenVoiceover,
  });

  @override
  State<YossefDesktopWorkspace> createState() => _YossefDesktopWorkspaceState();
}

class _YossefDesktopWorkspaceState extends State<YossefDesktopWorkspace> {
  bool showKeyframesInBottom = false;
  YossefStudioController get c => widget.controller;
  YossefThemeData get t => c.theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          Expanded(
            flex: (c.topRowFlex * 100).round(),
            child: Row(
              children: [
                Expanded(
                  flex: (c.leftColumnFlex * 100).round(),
                  child: YossefLibraryPane(
                    controller: c,
                    onOpenCaptions: widget.onOpenCaptions,
                    onOpenSpeech: widget.onOpenSpeech,
                    onOpenVoiceover: widget.onOpenVoiceover,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  flex: (c.centerColumnFlex * 100).round(),
                  child: YossefPreviewPane(controller: c),
                ),
                const SizedBox(width: 6),
                Expanded(
                  flex: (c.rightColumnFlex * 100).round(),
                  child: YossefInspectorPane(controller: c, onOpenSettings: widget.onOpenSettings),
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragUpdate: (details) {
              final h = MediaQuery.of(context).size.height;
              setState(() {
                c.topRowFlex = (c.topRowFlex + details.delta.dy / h).clamp(0.32, 0.72);
              });
            },
            child: Container(
              height: 6,
              alignment: Alignment.center,
              child: Container(
                width: 48, height: 2,
                decoration: BoxDecoration(color: t.lineStrong, borderRadius: BorderRadius.circular(1)),
              ),
            ),
          ),
          Expanded(
            flex: ((1.0 - c.topRowFlex) * 100).round(),
            child: showKeyframesInBottom
                ? YossefKeyframesPane(
                    controller: c,
                    onBackToTimeline: () => setState(() => showKeyframesInBottom = false),
                  )
                : YossefTimelinePane(
                    controller: c,
                    onOpenKeyframes: () => setState(() => showKeyframesInBottom = true),
                    onOpenCaptions: widget.onOpenCaptions,
                    onOpenSpeech: widget.onOpenSpeech,
                    onOpenVoiceover: widget.onOpenVoiceover,
                  ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 12. LIBRARY PANE
// ============================================================================
class YossefLibraryPane extends StatelessWidget {
  final YossefStudioController controller;
  final VoidCallback onOpenCaptions;
  final VoidCallback onOpenSpeech;
  final VoidCallback onOpenVoiceover;

  const YossefLibraryPane({
    super.key, required this.controller,
    required this.onOpenCaptions, required this.onOpenSpeech, required this.onOpenVoiceover,
  });

  @override
  Widget build(BuildContext context) {
    final t = controller.theme;
    final tabs = [
      (Icons.video_library_rounded, controller.tr('common.media')),
      (Icons.library_music_rounded, controller.tr('common.audio')),
      (Icons.title_rounded, controller.tr('common.text')),
      (Icons.auto_awesome_rounded, controller.tr('common.effects')),
      (Icons.tune_rounded, controller.tr('common.filters')),
      (Icons.wb_sunny_outlined, controller.tr('common.adjustments')),
      (Icons.swap_horiz_rounded, controller.tr('common.transitions')),
      (Icons.category_rounded, controller.tr('common.stickers')),
    ];

    return Container(
      decoration: BoxDecoration(
        color: t.panel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: t.line),
      ),
      child: Column(
        children: [
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: t.line))),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 4),
              itemBuilder: (context, idx) {
                final selected = controller.activeLibraryTab == idx;
                return InkWell(
                  onTap: () {
                    controller.activeLibraryTab = idx;
                    controller.librarySearchQuery = '';
                    controller.notifyUpdate();
                  },
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: selected ? t.fieldActive : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(tabs[idx].$1, size: 16,
                            color: selected ? t.accent : t.fgMuted),
                        const SizedBox(height: 2),
                        Text(tabs[idx].$2,
                            style: TextStyle(
                              color: selected ? t.fg : t.fgMuted,
                              fontSize: 10,
                              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextField(
                      controller: TextEditingController(text: controller.librarySearchQuery)
                        ..selection = TextSelection.collapsed(offset: controller.librarySearchQuery.length),
                      onChanged: (v) {
                        controller.librarySearchQuery = v;
                        controller.notifyUpdate();
                      },
                      style: TextStyle(color: t.fg, fontSize: 12),
                      decoration: InputDecoration(
                        hintText: controller.isArabic ? 'بحث في المكتبة...' : 'Search library...',
                        hintStyle: TextStyle(color: t.fgDim, fontSize: 11),
                        prefixIcon: Icon(Icons.search, size: 14, color: t.fgDim),
                        filled: true, fillColor: t.field,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                if (controller.activeLibraryTab == 0)
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: t.accent, foregroundColor: t.onAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      minimumSize: const Size(0, 30),
                    ),
                    onPressed: () {
                      controller.mediaBin.add(MediaBinItem(
                        id: 'm_${DateTime.now().millisecondsSinceEpoch}',
                        name: 'YOSSEF_Shot_${controller.mediaBin.length + 1}_8K.mp4',
                        kind: ClipKind.video, duration: 6.0,
                        format: 'MP4 · 10-bit HDR',
                        resolution: '7680×4320 · 60fps',
                        gradient: const [Color(0xFF1F4037), Color(0xFF99F2C8)],
                      ));
                      controller.notifyUpdate();
                    },
                    icon: const Icon(Icons.file_upload_outlined, size: 14),
                    label: Text(controller.isArabic ? 'استيراد' : 'Import',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
          ),
          Expanded(child: _buildShelfContent(context)),
        ],
      ),
    );
  }

  Widget _buildShelfContent(BuildContext context) {
    switch (controller.activeLibraryTab) {
      case 0: return _buildMediaBinGrid(context);
      case 1: return _buildAudioShelf(context);
      case 2: return _buildTextPresetsShelf(context);
      case 3: return _buildCatalogueGrid(context, 'effect');
      case 4: return _buildCatalogueGrid(context, 'filter');
      case 5: return _buildAdjustmentsAndLutsShelf(context);
      case 6: return _buildCatalogueGrid(context, 'transition');
      case 7: return _buildShapesShelf(context);
      default: return _buildMediaBinGrid(context);
    }
  }

  Widget _buildMediaBinGrid(BuildContext context) {
    final t = controller.theme;
    final items = controller.mediaBin.where((m) {
      if (controller.librarySearchQuery.trim().isEmpty) return true;
      return m.name.toLowerCase().contains(controller.librarySearchQuery.toLowerCase());
    }).toList();
    if (items.isEmpty) return _emptyState(context);

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 175, mainAxisExtent: 120,
        crossAxisSpacing: 8, mainAxisSpacing: 8,
      ),
      itemBuilder: (context, idx) {
        final item = items[idx];
        return InkWell(
          onTap: () => controller.addMediaFromBin(item),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: t.raised,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: t.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: item.gradient),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            item.kind == ClipKind.audio
                                ? Icons.graphic_eq_rounded
                                : item.kind == ClipKind.image
                                    ? Icons.image_outlined
                                    : Icons.movie_creation_outlined,
                            color: Colors.white.withOpacity(0.85), size: 26,
                          ),
                        ),
                        Positioned(
                          bottom: 4, right: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('${item.duration.toStringAsFixed(1)}s',
                                style: const TextStyle(color: Colors.white, fontSize: 10)),
                          ),
                        ),
                        Positioned(
                          top: 4, left: 4,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(color: t.accent, shape: BoxShape.circle),
                            child: Icon(Icons.add, size: 12, color: t.onAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: TextStyle(color: t.fg, fontSize: 11, fontWeight: FontWeight.w600),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(item.resolution,
                          style: TextStyle(color: t.fgDim, fontSize: 9.5),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAudioShelf(BuildContext context) {
    final t = controller.theme;
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Wrap(
          spacing: 8, runSpacing: 8,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: t.accent, foregroundColor: t.onAccent),
              onPressed: onOpenSpeech,
              icon: const Icon(Icons.record_voice_over_rounded, size: 15),
              label: Text(controller.tr('common.speech'),
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ),
            OutlinedButton.icon(
              onPressed: onOpenVoiceover,
              icon: Icon(Icons.mic_rounded, size: 15, color: t.danger),
              label: Text(controller.tr('common.voiceover'),
                  style: TextStyle(color: t.fg, fontSize: 11)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(controller.isArabic ? 'مؤثرات صوتية احترافية' : 'Studio Audio Processors',
            style: TextStyle(color: t.fgMuted, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...controller.packages.where((p) => p.kind == 'audio').map((pkg) {
          return Card(
            color: t.raised,
            margin: const EdgeInsets.only(bottom: 6),
            child: ListTile(
              dense: true,
              leading: CircleAvatar(
                radius: 16,
                backgroundColor: t.kindAudioWell,
                child: Icon(Icons.multitrack_audio_rounded, size: 16, color: t.kindAudio),
              ),
              title: Text(controller.isArabic ? pkg.nameAr : pkg.name,
                  style: TextStyle(color: t.fg, fontSize: 12, fontWeight: FontWeight.bold)),
              subtitle: Text(pkg.description, style: TextStyle(color: t.fgDim, fontSize: 10)),
              trailing: IconButton(
                icon: Icon(Icons.add_circle_rounded, color: t.accent),
                onPressed: () => controller.applyPackageToSelection(pkg),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTextPresetsShelf(BuildContext context) {
    final t = controller.theme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: t.accent, foregroundColor: t.onAccent),
                  onPressed: () => controller.addTextFromPreset(YossefCatalogues.textPresets.first),
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(controller.isArabic ? 'عنوان جديد' : 'Add Title',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 6),
              OutlinedButton.icon(
                onPressed: onOpenCaptions,
                icon: Icon(Icons.closed_caption_rounded, size: 16, color: t.accent),
                label: Text(controller.isArabic ? 'ترجمة AI' : 'AI Captions',
                    style: TextStyle(color: t.fg, fontSize: 11)),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: YossefCatalogues.textPresets.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 155, mainAxisExtent: 95,
              crossAxisSpacing: 8, mainAxisSpacing: 8,
            ),
            itemBuilder: (context, idx) {
              final preset = YossefCatalogues.textPresets[idx];
              return InkWell(
                onTap: () => controller.addTextFromPreset(preset),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF37373A),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: t.line),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: preset.backgroundColor ?? Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(preset.sample,
                            style: TextStyle(
                              color: preset.color, fontWeight: FontWeight.w700, fontSize: 17,
                            )),
                      ),
                      const SizedBox(height: 6),
                      Text(preset.name,
                          style: TextStyle(color: t.fgMuted, fontSize: 10.5),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCatalogueGrid(BuildContext context, String kind) {
    final t = controller.theme;
    final list = controller.packages.where((p) {
      if (p.kind != kind) return false;
      if (controller.librarySearchQuery.trim().isEmpty) return true;
      final q = controller.librarySearchQuery.toLowerCase();
      return p.name.toLowerCase().contains(q) ||
          p.nameAr.contains(q) ||
          p.category.toLowerCase().contains(q);
    }).toList();

    if (list.isEmpty) return _emptyState(context);

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 165, mainAxisExtent: 112,
        crossAxisSpacing: 8, mainAxisSpacing: 8,
      ),
      itemBuilder: (context, idx) {
        final pkg = list[idx];
        return InkWell(
          onTap: () => controller.applyPackageToSelection(pkg),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: t.raised,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: t.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: pkg.previewGradient,
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(pkg.category.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85), fontSize: 10,
                                fontWeight: FontWeight.w900, letterSpacing: 0.7,
                              )),
                        ),
                        Positioned(
                          top: 4, right: 4,
                          child: InkWell(
                            onTap: () {
                              pkg.favourite = !pkg.favourite;
                              controller.notifyUpdate();
                            },
                            child: Icon(
                              pkg.favourite ? Icons.star_rounded : Icons.star_border_rounded,
                              size: 16,
                              color: pkg.favourite ? Colors.amber : Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(controller.isArabic ? pkg.nameAr : pkg.name,
                      style: TextStyle(color: t.fg, fontSize: 11, fontWeight: FontWeight.bold),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdjustmentsAndLutsShelf(BuildContext context) {
    final t = controller.theme;
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: t.accent, foregroundColor: t.onAccent,
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
          onPressed: controller.addAdjustmentLayer,
          icon: const Icon(Icons.layers_rounded, size: 16),
          label: Text(controller.isArabic ? 'إضافة طبقة تعديل ألوان' : 'Add Adjustment Layer',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        Text(controller.isArabic ? 'ملفات .CUBE LUTs سينمائية' : 'Cinematic .CUBE LUTs',
            style: TextStyle(color: t.fgMuted, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...[
          ('YOSSEF ARRI Alexa LogC to Rec709.cube', [const Color(0xFF2C3E50), const Color(0xFF4CA1AF)]),
          ('YOSSEF Kodak 2383 Print Film.cube', [const Color(0xFF834D9B), const Color(0xFFD04ED6)]),
          ('YOSSEF Anamorphic Teal Gold.cube', [const Color(0xFF005C97), const Color(0xFFFF8008)]),
          ('YOSSEF Cairo Golden Desert HDR.cube', [const Color(0xFFF7971E), const Color(0xFFFFD200)]),
          ('YOSSEF Netflix Original.cube', [const Color(0xFF232526), const Color(0xFF414345)]),
        ].map((lut) {
          return Card(
            color: t.raised,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              dense: true,
              leading: Container(
                width: 34, height: 34,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: lut.$2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.wb_iridescent_rounded, color: Colors.white, size: 16),
              ),
              title: Text(lut.$1,
                  style: TextStyle(color: t.fg, fontSize: 11.5, fontWeight: FontWeight.bold)),
              trailing: IconButton(
                icon: Icon(Icons.add_circle_outline, color: t.accent, size: 18),
                onPressed: controller.addAdjustmentLayer,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildShapesShelf(BuildContext context) {
    final t = controller.theme;
    final shapes = [
      ('rectangle', controller.isArabic ? 'مستطيل' : 'Rectangle', Icons.crop_square_rounded, const Color(0xFFCBF53F)),
      ('circle', controller.isArabic ? 'دائرة' : 'Circle', Icons.circle_outlined, const Color(0xFF5FB8FF)),
      ('star', controller.isArabic ? 'نجمة' : 'Star', Icons.star_rounded, const Color(0xFFFFB340)),
      ('arrow', controller.isArabic ? 'سهم' : 'Arrow', Icons.trending_flat_rounded, const Color(0xFFFF6FA3)),
      ('badge', controller.isArabic ? 'شارة YOSSEF' : 'YOSSEF Badge', Icons.verified_rounded, const Color(0xFF3FDCC4)),
    ];
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: shapes.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 140, mainAxisExtent: 100,
        crossAxisSpacing: 8, mainAxisSpacing: 8,
      ),
      itemBuilder: (context, idx) {
        final s = shapes[idx];
        return InkWell(
          onTap: () => controller.addShapeClip(s.$1, s.$2, s.$4),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: t.raised,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: t.line),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(s.$3, size: 32, color: s.$4),
                const SizedBox(height: 6),
                Text(s.$2, style: TextStyle(color: t.fg, fontSize: 11, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _emptyState(BuildContext context) {
    final t = controller.theme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 42, color: t.fgDim),
          const SizedBox(height: 8),
          Text(controller.isArabic ? 'لا توجد نتائج' : 'No results',
              style: TextStyle(color: t.fgMuted, fontSize: 12)),
        ],
      ),
    );
  }
}

// ============================================================================
// 13. PREVIEW PANE
// ============================================================================
class YossefPreviewPane extends StatelessWidget {
  final YossefStudioController controller;
  final bool bare;

  const YossefPreviewPane({super.key, required this.controller, this.bare = false});

  @override
  Widget build(BuildContext context) {
    final t = controller.theme;
    final activeClips = controller.activeClipsAtPlayhead;
    final selected = controller.selectedClip;

    return Container(
      decoration: BoxDecoration(
        color: t.panel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: t.line),
      ),
      child: Column(
        children: [
          if (!bare)
            Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: t.line))),
              child: Row(
                children: [
                  Icon(Icons.tv_rounded, size: 15, color: t.accent),
                  const SizedBox(width: 6),
                  Text(controller.tr('common.preview'),
                      style: TextStyle(color: t.fg, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: t.accentSoft, borderRadius: BorderRadius.circular(4)),
                    child: Text('GPU 10-BIT · ${controller.outputWidth}×${controller.outputHeight}',
                        style: TextStyle(color: t.accent, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                  const Spacer(),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: controller.previewQualityIndex,
                      dropdownColor: t.raised,
                      style: TextStyle(color: t.fg, fontSize: 11),
                      items: const [
                        DropdownMenuItem(value: 0, child: Text('Ultra Full')),
                        DropdownMenuItem(value: 1, child: Text('Half')),
                        DropdownMenuItem(value: 2, child: Text('Quarter')),
                      ],
                      onChanged: (v) {
                        if (v != null) {
                          controller.previewQualityIndex = v;
                          controller.notifyUpdate();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: t.lineStrong),
              ),
              clipBehavior: Clip.antiAlias,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    onPanUpdate: (details) {
                      if (selected != null) {
                        selected.posX = (selected.posX +
                            details.delta.dx / (constraints.maxWidth * 0.5)).clamp(-1.0, 1.0);
                        selected.posY = (selected.posY +
                            details.delta.dy / (constraints.maxHeight * 0.5)).clamp(-1.0, 1.0);
                        controller.notifyUpdate();
                      }
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        for (final clip in activeClips)
                          if (clip.kind != ClipKind.audio)
                            _buildCompositedClipLayer(clip, constraints),
                        CustomPaint(painter: _StageGuidesPainter(
                          accentColor: t.accent, selectedClip: selected,
                        )),
                        Positioned(
                          top: 10, right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: t.accent.withOpacity(0.5)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.bolt_rounded, size: 13, color: t.accent),
                                const SizedBox(width: 4),
                                Text('YOSSEF · ${controller.frameRate.toInt()} FPS',
                                    style: TextStyle(color: t.accent, fontSize: 10, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        if (selected != null && (selected.aiEnhanced || selected.cutoutMode > 0))
                          Positioned(
                            top: 10, left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                [
                                  if (selected.aiEnhanced) 'AI 8K',
                                  if (selected.cutoutMode == 1) 'AI Cutout',
                                  if (selected.cutoutMode == 3) 'Chroma',
                                ].join(' · '),
                                style: TextStyle(color: t.green, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: t.line))),
            child: Row(
              children: [
                Text(_formatTimecode(controller.playhead, controller.frameRate),
                    style: TextStyle(
                      color: t.accent, fontSize: 13,
                      fontWeight: FontWeight.w800, fontFamily: 'monospace',
                    )),
                Text(' / ${_formatTimecode(controller.timelineDuration, controller.frameRate)}',
                    style: TextStyle(color: t.fgDim, fontSize: 12, fontFamily: 'monospace')),
                const Spacer(),
                IconButton(
                  tooltip: 'Start',
                  onPressed: () => controller.seek(0.0),
                  icon: Icon(Icons.skip_previous_rounded, size: 19, color: t.fgMuted),
                ),
                IconButton(
                  tooltip: 'Prev Frame (←)',
                  onPressed: () => controller.stepFrames(-1),
                  icon: Icon(Icons.navigate_before_rounded, size: 20, color: t.fg),
                ),
                InkWell(
                  onTap: controller.togglePlay,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 34, height: 34,
                    decoration: BoxDecoration(color: t.accent, shape: BoxShape.circle),
                    child: Icon(
                      controller.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      color: t.onAccent, size: 22,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Next Frame (→)',
                  onPressed: () => controller.stepFrames(1),
                  icon: Icon(Icons.navigate_next_rounded, size: 20, color: t.fg),
                ),
                IconButton(
                  tooltip: 'Split (S)',
                  onPressed: controller.splitSelectedOrAtPlayhead,
                  icon: Icon(Icons.content_cut_rounded, size: 17, color: t.accent),
                ),
                const Spacer(),
                Text(selected != null ? selected.name : 'YOSSEF Stage',
                    style: TextStyle(color: t.fgMuted, fontSize: 11),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompositedClipLayer(TimelineClip clip, BoxConstraints constraints) {
    final dx = clip.posX * (constraints.maxWidth * 0.35);
    final dy = clip.posY * (constraints.maxHeight * 0.35);
    final expFactor = math.pow(2.0, clip.exposure * 0.35).toDouble();
    final satFactor = ((100.0 + clip.saturation + clip.vibrance * 0.5) / 100.0).clamp(0.0, 2.5);

    Widget content;
    if (clip.kind == ClipKind.text) {
      content = Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: clip.textBackgroundPlate ?? Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(clip.textContent,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: clip.textColor,
                fontSize: clip.fontSize * 0.72,
                fontWeight: FontWeight.w900,
                shadows: clip.textShadow
                    ? [Shadow(
                        color: clip.textStrokeColor,
                        blurRadius: clip.textStrokeWidth * 2,
                        offset: const Offset(0, 2),
                      )]
                    : null,
              )),
        ),
      );
    } else if (clip.kind == ClipKind.shape) {
      content = Center(
        child: Container(
          width: 120, height: 120,
          decoration: BoxDecoration(
            color: clip.shapeColor.withOpacity(0.85),
            shape: clip.shapeType == 'circle' ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: clip.shapeType == 'circle' ? null : BorderRadius.circular(16),
          ),
          child: Center(
            child: Text('YOSSEF',
                style: TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.w900)),
          ),
        ),
      );
    } else if (clip.kind == ClipKind.filter) {
      content = Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xFF005C97).withOpacity(0.18 * clip.opacity),
            const Color(0xFFFF8008).withOpacity(0.18 * clip.opacity),
          ]),
        ),
      );
    } else {
      content = Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: clip.previewColors.map((c) => Color.fromARGB(
              255,
              (c.red * expFactor).round().clamp(0, 255),
              (c.green * expFactor).round().clamp(0, 255),
              (c.blue * satFactor).round().clamp(0, 255),
            )).toList(),
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.hd_rounded, size: 46, color: Colors.white.withOpacity(0.28)),
              const SizedBox(height: 6),
              Text(clip.name,
                  style: TextStyle(color: Colors.white.withOpacity(0.7),
                      fontSize: 13, fontWeight: FontWeight.bold)),
              if (clip.visualChain.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Wrap(
                    spacing: 4,
                    children: clip.visualChain
                        .where((e) => e.enabled)
                        .map((e) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black45, borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(e.name,
                                  style: const TextStyle(color: Color(0xFFCBF53F), fontSize: 10)),
                            ))
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return Opacity(
      opacity: clip.opacity.clamp(0.0, 1.0),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translate(dx, dy)
          ..rotateZ(clip.rotation * math.pi / 180.0)
          ..scale(
            (clip.flipH ? -1.0 : 1.0) * clip.scale,
            (clip.flipV ? -1.0 : 1.0) * clip.scale,
          ),
        child: content,
      ),
    );
  }

  static String _formatTimecode(double seconds, double fps) {
    final totalFrames = (seconds * fps).round();
    final f = totalFrames % fps.round();
    final totalSecs = totalFrames ~/ fps.round();
    final s = totalSecs % 60;
    final m = (totalSecs ~/ 60) % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}:${f.toString().padLeft(2, '0')}';
  }
}

class _StageGuidesPainter extends CustomPainter {
  final Color accentColor;
  final TimelineClip? selectedClip;
  _StageGuidesPainter({required this.accentColor, required this.selectedClip});

  @override
  void paint(Canvas canvas, Size size) {
    final guidePaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(size.width / 3, 0), Offset(size.width / 3, size.height), guidePaint);
    canvas.drawLine(Offset(size.width * 2 / 3, 0), Offset(size.width * 2 / 3, size.height), guidePaint);
    canvas.drawLine(Offset(0, size.height / 3), Offset(size.width, size.height / 3), guidePaint);
    canvas.drawLine(Offset(0, size.height * 2 / 3), Offset(size.width, size.height * 2 / 3), guidePaint);

    if (selectedClip != null && selectedClip!.kind != ClipKind.audio) {
      final cx = size.width / 2 + selectedClip!.posX * (size.width * 0.35);
      final cy = size.height / 2 + selectedClip!.posY * (size.height * 0.35);
      final boxW = (size.width * 0.55) * selectedClip!.scale.clamp(0.2, 2.0);
      final boxH = (size.height * 0.55) * selectedClip!.scale.clamp(0.2, 2.0);
      final rect = Rect.fromCenter(center: Offset(cx, cy), width: boxW, height: boxH);
      final boxPaint = Paint()
        ..color = accentColor
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;
      canvas.drawRect(rect, boxPaint);
      final handlePaint = Paint()..color = accentColor;
      for (final corner in [rect.topLeft, rect.topRight, rect.bottomLeft, rect.bottomRight]) {
        canvas.drawCircle(corner, 4.5, handlePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _StageGuidesPainter oldDelegate) => true;
}

// ============================================================================
// 14. INSPECTOR PANE
// ============================================================================
class YossefInspectorPane extends StatelessWidget {
  final YossefStudioController controller;
  final void Function({int initialTab}) onOpenSettings;

  const YossefInspectorPane({
    super.key, required this.controller, required this.onOpenSettings,
  });

  @override
  Widget build(BuildContext context) {
    final t = controller.theme;
    final clip = controller.selectedClip;

    return Container(
      decoration: BoxDecoration(
        color: t.panel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: t.line),
      ),
      child: clip == null
          ? _buildProjectDetailsView(context)
          : Column(
              children: [
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: t.line))),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildTabChip(0, Icons.transform_rounded, controller.isArabic ? 'تحريك' : 'Video'),
                      _buildTabChip(1, Icons.palette_outlined, controller.isArabic ? 'ألوان' : 'Color'),
                      _buildTabChip(2, Icons.auto_awesome_motion, controller.isArabic ? 'مؤثرات' : 'Effects'),
                      _buildTabChip(3, Icons.volume_up_rounded, controller.isArabic ? 'صوت' : 'Audio'),
                      _buildTabChip(4, Icons.speed_rounded, controller.isArabic ? 'سرعة' : 'Speed'),
                      _buildTabChip(5, Icons.auto_fix_high_rounded, controller.isArabic ? 'AI' : 'AI'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  color: t.well,
                  child: Row(
                    children: [
                      Icon(Icons.movie_edit, size: 15, color: t.accent),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(clip.name,
                            style: TextStyle(color: t.fg, fontSize: 12, fontWeight: FontWeight.bold),
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      Text('${clip.duration.toStringAsFixed(2)}s',
                          style: TextStyle(color: t.accent, fontSize: 11, fontFamily: 'monospace')),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      if (controller.activeInspectorTab == 0) _buildTransformTab(clip),
                      if (controller.activeInspectorTab == 1) _buildColorGradingTab(clip),
                      if (controller.activeInspectorTab == 2) _buildEffectsChainTab(clip),
                      if (controller.activeInspectorTab == 3) _buildAudioTab(clip),
                      if (controller.activeInspectorTab == 4) _buildSpeedRampTab(clip),
                      if (controller.activeInspectorTab == 5) _buildAiAndMaskTab(clip),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTabChip(int index, IconData icon, String label) {
    final t = controller.theme;
    final active = controller.activeInspectorTab == index;
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: InkWell(
        onTap: () {
          controller.activeInspectorTab = index;
          controller.notifyUpdate();
        },
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: active ? t.accent : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: active ? t.onAccent : t.fgMuted),
              const SizedBox(width: 4),
              Text(label,
                  style: TextStyle(
                    color: active ? t.onAccent : t.fgMuted,
                    fontSize: 11,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectDetailsView(BuildContext context) {
    final t = controller.theme;
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Row(
          children: [
            Icon(Icons.info_outline_rounded, size: 16, color: t.accent),
            const SizedBox(width: 6),
            Text(controller.isArabic ? 'تفاصيل المشروع' : 'Project Details',
                style: TextStyle(color: t.fg, fontSize: 13, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        _buildFactRow(controller.tr('common.name'), controller.projectName),
        _buildFactRow(controller.tr('common.location'), controller.projectLocation),
        _buildFactRow(controller.tr('common.size'),
            '${controller.outputWidth} × ${controller.outputHeight}'),
        _buildFactRow(controller.tr('common.frameRate'),
            '${controller.frameRate.toStringAsFixed(2)} fps'),
        _buildFactRow('Color Space', controller.colorSpace),
        _buildFactRow(controller.tr('common.media'), '${controller.mediaBin.length} files'),
        _buildFactRow('Clips', '${controller.clips.length} clips'),
        const Divider(height: 24),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: t.accentSoft,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: t.accent),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('حقوق الملكية: YOSSEF',
                  style: TextStyle(color: t.accent, fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 4),
              Text('المطور: يوسف حامد\nواتساب: 01029892573',
                  style: TextStyle(color: t.fg, fontSize: 11.5)),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: t.accent, foregroundColor: t.onAccent,
                  ),
                  onPressed: () => onOpenSettings(initialTab: 7),
                  icon: const Icon(Icons.settings, size: 15),
                  label: Text(controller.isArabic ? 'ضبط المطور' : 'Developer Settings',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFactRow(String label, String value) {
    final t = controller.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: t.fgMuted, fontSize: 11.5)),
          Flexible(
            child: Text(value,
                style: TextStyle(color: t.fg, fontSize: 11.5, fontWeight: FontWeight.w600),
                textAlign: TextAlign.end, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget _buildTransformTab(TimelineClip clip) {
    final t = controller.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (clip.kind == ClipKind.text) ...[
          Text(controller.isArabic ? 'محتوى النص' : 'Title Text',
              style: TextStyle(color: t.accent, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: clip.textContent,
            style: TextStyle(color: t.fg, fontSize: 12),
            onChanged: (v) {
              clip.textContent = v;
              controller.notifyUpdate();
            },
            decoration: InputDecoration(
              filled: true, fillColor: t.field,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            ),
          ),
          const SizedBox(height: 10),
          _buildParamSlider(
            label: controller.isArabic ? 'حجم الخط' : 'Font Size',
            value: clip.fontSize, min: 14, max: 96, unit: 'pt',
            onChanged: (v) {
              clip.fontSize = v;
              controller.notifyUpdate();
            },
          ),
          const Divider(height: 20),
        ],
        Text(controller.isArabic ? 'التحجيم والموضع' : 'Transform & Placement',
            style: TextStyle(color: t.fgMuted, fontSize: 11.5, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildParamSlider(
          label: 'Scale', value: clip.scale * 100, min: 10, max: 300, unit: '%',
          onKeyframe: () => controller.addKeyframeToSelected('scale', clip.scale / 3.0),
          onChanged: (v) {
            clip.scale = v / 100.0;
            controller.notifyUpdate();
          },
        ),
        _buildParamSlider(
          label: 'Pos X', value: clip.posX * 100, min: -100, max: 100, unit: '%',
          onKeyframe: () => controller.addKeyframeToSelected('posX', (clip.posX + 1) / 2),
          onChanged: (v) {
            clip.posX = v / 100.0;
            controller.notifyUpdate();
          },
        ),
        _buildParamSlider(
          label: 'Pos Y', value: clip.posY * 100, min: -100, max: 100, unit: '%',
          onKeyframe: () => controller.addKeyframeToSelected('posY', (clip.posY + 1) / 2),
          onChanged: (v) {
            clip.posY = v / 100.0;
            controller.notifyUpdate();
          },
        ),
        _buildParamSlider(
          label: 'Rotation', value: clip.rotation, min: -180, max: 180, unit: '°',
          onKeyframe: () => controller.addKeyframeToSelected('rotation', (clip.rotation + 180) / 360),
          onChanged: (v) {
            clip.rotation = v;
            controller.notifyUpdate();
          },
        ),
        _buildParamSlider(
          label: 'Opacity', value: clip.opacity * 100, min: 0, max: 100, unit: '%',
          onKeyframe: () => controller.addKeyframeToSelected('opacity', clip.opacity),
          onChanged: (v) {
            clip.opacity = v / 100.0;
            controller.notifyUpdate();
          },
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text('Blend', style: TextStyle(color: t.fgMuted, fontSize: 11.5)),
            const Spacer(),
            DropdownButton<String>(
              value: clip.blendMode,
              dropdownColor: t.raised,
              style: TextStyle(color: t.fg, fontSize: 11.5),
              items: ['Normal', 'Multiply', 'Screen', 'Overlay', 'Lighten', 'Darken']
                  .map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
              onChanged: (v) {
                if (v != null) {
                  clip.blendMode = v;
                  controller.notifyUpdate();
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildColorGradingTab(TimelineClip clip) {
    final t = controller.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(controller.isArabic ? 'عجلات الألوان' : '3-Way Color Wheels',
            style: TextStyle(color: t.accent, fontSize: 11.5, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildColorWheelControl('Lift', clip.liftWheel),
            _buildColorWheelControl('Gamma', clip.gammaWheel),
            _buildColorWheelControl('Gain', clip.gainWheel),
          ],
        ),
        const Divider(height: 22),
        _buildParamSlider(
          label: 'Exposure', value: clip.exposure, min: -4.0, max: 4.0, unit: ' EV',
          onChanged: (v) {
            clip.exposure = v;
            controller.notifyUpdate();
          },
        ),
        _buildParamSlider(
          label: 'Contrast', value: clip.contrast, min: -100, max: 100, unit: '',
          onChanged: (v) {
            clip.contrast = v;
            controller.notifyUpdate();
          },
        ),
        _buildParamSlider(
          label: 'Saturation', value: clip.saturation, min: -100, max: 100, unit: '',
          onChanged: (v) {
            clip.saturation = v;
            controller.notifyUpdate();
          },
        ),
        _buildParamSlider(
          label: 'Vibrance', value: clip.vibrance, min: -100, max: 100, unit: '',
          onChanged: (v) {
            clip.vibrance = v;
            controller.notifyUpdate();
          },
        ),
        _buildParamSlider(
          label: 'Temperature', value: clip.temperature, min: -100, max: 100, unit: 'K',
          onChanged: (v) {
            clip.temperature = v;
            controller.notifyUpdate();
          },
        ),
        _buildParamSlider(
          label: 'Sharpen', value: clip.sharpen, min: 0, max: 100, unit: '%',
          onChanged: (v) {
            clip.sharpen = v;
            controller.notifyUpdate();
          },
        ),
        _buildParamSlider(
          label: 'Vignette', value: clip.vignette, min: 0, max: 100, unit: '%',
          onChanged: (v) {
            clip.vignette = v;
            controller.notifyUpdate();
          },
        ),
      ],
    );
  }

  Widget _buildColorWheelControl(String title, ColorWheelState wheel) {
    final t = controller.theme;
    return Column(
      children: [
        Text(title, style: TextStyle(color: t.fgMuted, fontSize: 10.5, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        GestureDetector(
          onPanUpdate: (d) {
            wheel.x = (wheel.x + d.delta.dx / 32.0).clamp(-1.0, 1.0);
            wheel.y = (wheel.y + d.delta.dy / 32.0).clamp(-1.0, 1.0);
            controller.notifyUpdate();
          },
          onDoubleTap: () {
            wheel.x = 0.0;
            wheel.y = 0.0;
            controller.notifyUpdate();
          },
          child: Container(
            width: 68, height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: t.lineStrong, width: 1.5),
              gradient: const SweepGradient(colors: [
                Colors.red, Colors.yellow, Colors.green,
                Colors.cyan, Colors.blue, Colors.purple, Colors.red,
              ]),
            ),
            child: Center(
              child: Transform.translate(
                offset: Offset(wheel.x * 22, wheel.y * 22),
                child: Container(
                  width: 12, height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEffectsChainTab(TimelineClip clip) {
    final t = controller.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(controller.isArabic ? 'سلسلة المؤثرات' : 'Applied Effects Chain',
            style: TextStyle(color: t.accent, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (clip.visualChain.isEmpty)
          Text(controller.isArabic ? 'لا توجد مؤثرات مضافة' : 'No visual effects applied',
              style: TextStyle(color: t.fgDim, fontSize: 11.5)),
        ...clip.visualChain.asMap().entries.map((entry) {
          final i = entry.key;
          final eff = entry.value;
          return Card(
            color: t.raised,
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Switch(
                        value: eff.enabled,
                        activeColor: t.accent,
                        onChanged: (v) {
                          eff.enabled = v;
                          controller.notifyUpdate();
                        },
                      ),
                      Expanded(
                        child: Text(eff.name,
                            style: TextStyle(color: t.fg, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline, size: 16, color: t.danger),
                        onPressed: () {
                          clip.visualChain.removeAt(i);
                          controller.notifyUpdate();
                        },
                      ),
                    ],
                  ),
                  _buildParamSlider(
                    label: 'Intensity', value: eff.intensity, min: 0, max: 100, unit: '%',
                    onChanged: (v) {
                      eff.intensity = v;
                      controller.notifyUpdate();
                    },
                  ),
                ],
              ),
            ),
          );
        }),
        if (clip.transitionName != null) ...[
          const Divider(height: 20),
          ListTile(
            tileColor: t.raised,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            leading: Icon(Icons.swap_horiz_rounded, color: t.accent),
            title: Text('Transition: ${clip.transitionName}',
                style: TextStyle(color: t.fg, fontSize: 12, fontWeight: FontWeight.bold)),
            subtitle: Text('${clip.transitionDuration.toStringAsFixed(1)}s'),
            trailing: IconButton(
              icon: Icon(Icons.close, size: 16, color: t.fgMuted),
              onPressed: () {
                clip.transitionId = null;
                clip.transitionName = null;
                controller.notifyUpdate();
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAudioTab(TimelineClip clip) {
    final t = controller.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParamSlider(
          label: 'Volume', value: clip.volume * 100, min: 0, max: 200, unit: '%',
          onChanged: (v) {
            clip.volume = v / 100.0;
            controller.notifyUpdate();
          },
        ),
        _buildParamSlider(
          label: 'Fade In', value: clip.fadeIn, min: 0, max: 5.0, unit: 's',
          onChanged: (v) {
            clip.fadeIn = v;
            controller.notifyUpdate();
          },
        ),
        _buildParamSlider(
          label: 'Fade Out', value: clip.fadeOut, min: 0, max: 5.0, unit: 's',
          onChanged: (v) {
            clip.fadeOut = v;
            controller.notifyUpdate();
          },
        ),
        const Divider(height: 20),
        Text(controller.isArabic ? 'معالجة صوت AI' : 'One-Switch AI Voice Cleanup',
            style: TextStyle(color: t.accent, fontSize: 11.5, fontWeight: FontWeight.bold)),
        SwitchListTile(
          dense: true, contentPadding: EdgeInsets.zero, activeColor: t.accent,
          title: Text('AI Noise Reduction', style: TextStyle(color: t.fg, fontSize: 12)),
          value: clip.denoise,
          onChanged: (v) {
            clip.denoise = v;
            controller.notifyUpdate();
          },
        ),
        SwitchListTile(
          dense: true, contentPadding: EdgeInsets.zero, activeColor: t.accent,
          title: Text('Enhance Broadcast Voice', style: TextStyle(color: t.fg, fontSize: 12)),
          value: clip.enhanceVoice,
          onChanged: (v) {
            clip.enhanceVoice = v;
            controller.notifyUpdate();
          },
        ),
        SwitchListTile(
          dense: true, contentPadding: EdgeInsets.zero, activeColor: t.accent,
          title: Text('Normalize Loudness (-14 LUFS)', style: TextStyle(color: t.fg, fontSize: 12)),
          value: clip.normalizeLoudness,
          onChanged: (v) {
            clip.normalizeLoudness = v;
            controller.notifyUpdate();
          },
        ),
      ],
    );
  }

  Widget _buildSpeedRampTab(TimelineClip clip) {
    final t = controller.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParamSlider(
          label: 'Playback Speed', value: clip.speed, min: 0.1, max: 16.0, unit: 'x',
          onChanged: (v) {
            clip.speed = v;
            controller.notifyUpdate();
          },
        ),
        SwitchListTile(
          dense: true, contentPadding: EdgeInsets.zero, activeColor: t.accent,
          title: Text('Keep Audio Pitch', style: TextStyle(color: t.fg, fontSize: 12)),
          value: clip.keepPitch,
          onChanged: (v) {
            clip.keepPitch = v;
            controller.notifyUpdate();
          },
        ),
        const Divider(height: 18),
        Text(controller.isArabic ? 'قوالب منحنى السرعة' : 'Speed Ramp Presets',
            style: TextStyle(color: t.accent, fontSize: 11.5, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6, runSpacing: 6,
          children: ['Constant', 'Montage', 'Hero', 'Bullet', 'Jump Cut', 'Flash In'].map((preset) {
            final selected = clip.speedPreset == preset;
            return ChoiceChip(
              label: Text(preset, style: const TextStyle(fontSize: 11)),
              selected: selected,
              selectedColor: t.accent,
              onSelected: (_) {
                clip.speedPreset = preset;
                clip.speedCurved = preset != 'Constant';
                controller.notifyUpdate();
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAiAndMaskTab(TimelineClip clip) {
    final t = controller.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: t.raised,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: clip.aiEnhanced ? t.accent : t.line),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.hd_rounded, color: t.accent, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(controller.tr('common.enhance'),
                        style: TextStyle(color: t.fg, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  Switch(
                    value: clip.aiEnhanced, activeColor: t.accent,
                    onChanged: (v) {
                      clip.aiEnhanced = v;
                      controller.notifyUpdate();
                    },
                  ),
                ],
              ),
              Text(controller.isArabic ? 'ترميم ورفع الدقة عبر Real-ESRGAN' : 'Upscale via Real-ESRGAN',
                  style: TextStyle(color: t.fgDim, fontSize: 10.5)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(controller.tr('common.cutout'),
            style: TextStyle(color: t.accent, fontSize: 11.5, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          children: [
            (0, controller.isArabic ? 'إيقاف' : 'Off'),
            (1, controller.isArabic ? 'AI تلقائي' : 'AI Auto'),
            (2, controller.isArabic ? 'فرشاة' : 'Brush'),
            (3, controller.isArabic ? 'كروما' : 'Chroma'),
          ].map((mode) {
            return ChoiceChip(
              label: Text(mode.$2, style: const TextStyle(fontSize: 11)),
              selected: clip.cutoutMode == mode.$1,
              selectedColor: t.accent,
              onSelected: (_) {
                clip.cutoutMode = mode.$1;
                controller.notifyUpdate();
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        Text(controller.tr('common.mask'),
            style: TextStyle(color: t.accent, fontSize: 11.5, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6, runSpacing: 6,
          children: [
            (-1, controller.isArabic ? 'بلا' : 'None'),
            (0, controller.isArabic ? 'خطي' : 'Linear'),
            (1, controller.isArabic ? 'مرآة' : 'Mirror'),
            (2, controller.isArabic ? 'دائري' : 'Circle'),
            (3, controller.isArabic ? 'مستطيل' : 'Rectangle'),
            (4, controller.isArabic ? 'قلب' : 'Heart'),
            (5, controller.isArabic ? 'نجمة' : 'Star'),
          ].map((m) {
            return ChoiceChip(
              label: Text(m.$2, style: const TextStyle(fontSize: 10.5)),
              selected: clip.maskShape == m.$1,
              selectedColor: t.accent,
              onSelected: (_) {
                clip.maskShape = m.$1;
                controller.notifyUpdate();
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildParamSlider({
    required String label, required double value,
    required double min, required double max, required String unit,
    VoidCallback? onKeyframe, required ValueChanged<double> onChanged,
  }) {
    final t = controller.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: TextStyle(color: t.fgMuted, fontSize: 11)),
              const Spacer(),
              Text('${value.toStringAsFixed(1)}$unit',
                  style: TextStyle(color: t.fg, fontSize: 11, fontFamily: 'monospace')),
              if (onKeyframe != null) ...[
                const SizedBox(width: 6),
                InkWell(
                  onTap: onKeyframe,
                  child: Icon(Icons.diamond_outlined, size: 14, color: t.accent),
                ),
              ],
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
              activeTrackColor: t.accent,
              inactiveTrackColor: t.fieldActive,
              thumbColor: t.fg,
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min, max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 15. TIMELINE PANE
// ============================================================================
class YossefTimelinePane extends StatelessWidget {
  final YossefStudioController controller;
  final VoidCallback onOpenKeyframes;
  final VoidCallback onOpenCaptions;
  final VoidCallback onOpenSpeech;
  final VoidCallback onOpenVoiceover;

  const YossefTimelinePane({
    super.key, required this.controller, required this.onOpenKeyframes,
    required this.onOpenCaptions, required this.onOpenSpeech, required this.onOpenVoiceover,
  });

  @override
  Widget build(BuildContext context) {
    final t = controller.theme;
    return Container(
      decoration: BoxDecoration(
        color: t.panel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: t.line),
      ),
      child: Column(
        children: [
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: t.well,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
              border: Border(bottom: BorderSide(color: t.line)),
            ),
            child: Row(
              children: [
                ...List.generate(controller.timelineTabs.length, (idx) {
                  final active = controller.currentTimelineTab == idx;
                  return InkWell(
                    onTap: () {
                      controller.currentTimelineTab = idx;
                      controller.notifyUpdate();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: active ? t.panel : Colors.transparent,
                        border: Border(
                          top: BorderSide(
                            color: active ? t.accent : Colors.transparent, width: 2,
                          ),
                        ),
                      ),
                      child: Text(controller.timelineTabs[idx],
                          style: TextStyle(
                            color: active ? t.fg : t.fgMuted,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.bold : FontWeight.normal,
                          )),
                    ),
                  );
                }),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28),
                  icon: Icon(Icons.add, size: 15, color: t.fgMuted),
                  onPressed: () {
                    controller.timelineTabs.add('Timeline ${controller.timelineTabs.length + 1}');
                    controller.currentTimelineTab = controller.timelineTabs.length - 1;
                    controller.notifyUpdate();
                  },
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onOpenKeyframes,
                  icon: Icon(Icons.timeline_rounded, size: 14, color: t.accent),
                  label: Text(controller.tr('common.keyframes'),
                      style: TextStyle(color: t.accent, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: t.line))),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _trayButton(icon: Icons.undo_rounded, tooltip: 'Undo (Ctrl+Z)',
                    enabled: controller.canUndo, onTap: controller.undo),
                _trayButton(icon: Icons.redo_rounded, tooltip: 'Redo',
                    enabled: controller.canRedo, onTap: controller.redo),
                const VerticalDivider(width: 14),
                _trayButton(icon: Icons.near_me_rounded, tooltip: 'Select (V)',
                    active: controller.activeTool == TimelineTool.select,
                    onTap: () {
                      controller.activeTool = TimelineTool.select;
                      controller.notifyUpdate();
                    }),
                _trayButton(icon: Icons.content_cut_rounded, tooltip: 'Split (S)',
                    onTap: controller.splitSelectedOrAtPlayhead),
                _trayButton(icon: Icons.copy_rounded, tooltip: 'Duplicate (Ctrl+D)',
                    onTap: controller.duplicateSelectedClip),
                _trayButton(icon: Icons.delete_outline_rounded, tooltip: 'Delete',
                    onTap: controller.deleteSelectedClip),
                const VerticalDivider(width: 14),
                _trayButton(icon: Icons.attractions_rounded, tooltip: 'Magnetic',
                    active: controller.magneticTimeline,
                    onTap: () {
                      controller.magneticTimeline = !controller.magneticTimeline;
                      controller.notifyUpdate();
                    }),
                _trayButton(icon: Icons.grid_goldenratio_rounded, tooltip: 'Snap',
                    active: controller.snapToGrid,
                    onTap: () {
                      controller.snapToGrid = !controller.snapToGrid;
                      controller.notifyUpdate();
                    }),
                const VerticalDivider(width: 14),
                _trayButton(icon: Icons.ac_unit_rounded, tooltip: 'Freeze',
                    onTap: controller.freezeFrameSelectedClip),
                _trayButton(icon: Icons.swap_horizontal_circle_outlined, tooltip: 'Reverse',
                    onTap: controller.reverseSelectedClip),
                _trayButton(icon: Icons.flip_rounded, tooltip: 'Mirror',
                    onTap: controller.mirrorSelectedClip),
                _trayButton(icon: Icons.rotate_90_degrees_cw_outlined, tooltip: 'Rotate',
                    onTap: controller.rotateSelectedClip),
                const VerticalDivider(width: 14),
                _trayButton(icon: Icons.closed_caption_outlined, tooltip: 'AI Captions',
                    onTap: onOpenCaptions),
                _trayButton(icon: Icons.record_voice_over_outlined, tooltip: 'AI Speech',
                    onTap: onOpenSpeech),
                _trayButton(icon: Icons.mic_none_rounded, tooltip: 'Voiceover',
                    onTap: onOpenVoiceover),
                const VerticalDivider(width: 14),
                _trayButton(icon: Icons.zoom_out_rounded, tooltip: 'Zoom Out',
                    onTap: () {
                      controller.zoomPixelsPerSecond =
                          (controller.zoomPixelsPerSecond / 1.25).clamp(20.0, 200.0);
                      controller.notifyUpdate();
                    }),
                _trayButton(icon: Icons.zoom_in_rounded, tooltip: 'Zoom In',
                    onTap: () {
                      controller.zoomPixelsPerSecond =
                          (controller.zoomPixelsPerSecond * 1.25).clamp(20.0, 200.0);
                      controller.notifyUpdate();
                    }),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 195,
                  decoration: BoxDecoration(
                    color: t.panel,
                    border: Border(right: BorderSide(color: t.line)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 24,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        color: t.ruler,
                        child: Text('TRACKS (${controller.tracks.length})',
                            style: TextStyle(color: t.fgDim, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.tracks.length,
                          itemBuilder: (context, idx) {
                            final trk = controller.tracks[idx];
                            return Container(
                              height: trk.height,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: idx.isEven ? t.lane : t.laneAlt,
                                border: Border(bottom: BorderSide(color: t.line)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(trk.name,
                                        style: TextStyle(color: t.fg, fontSize: 10.5,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 1, overflow: TextOverflow.ellipsis),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      trk.visible = !trk.visible;
                                      controller.notifyUpdate();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        trk.visible ? Icons.visibility : Icons.visibility_off,
                                        size: 13,
                                        color: trk.visible ? t.fgMuted : t.danger,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      trk.muted = !trk.muted;
                                      controller.notifyUpdate();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        trk.muted ? Icons.volume_off : Icons.volume_up,
                                        size: 13,
                                        color: trk.muted ? t.danger : t.fgMuted,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final totalWidth = math.max(
                        constraints.maxWidth,
                        controller.timelineDuration * controller.zoomPixelsPerSecond + 120,
                      );
                      return GestureDetector(
                        onTapDown: (d) {
                          final secs = d.localPosition.dx / controller.zoomPixelsPerSecond;
                          controller.seek(secs);
                        },
                        onHorizontalDragUpdate: (d) {
                          final secs = d.localPosition.dx / controller.zoomPixelsPerSecond;
                          controller.seek(secs);
                        },
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: totalWidth,
                            height: constraints.maxHeight,
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 24,
                                      width: totalWidth,
                                      color: t.ruler,
                                      child: CustomPaint(
                                        painter: _TimelineRulerPainter(
                                          pixelsPerSecond: controller.zoomPixelsPerSecond,
                                          textColor: t.fgDim,
                                          lineColor: t.lineStrong,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: controller.tracks.length,
                                        itemBuilder: (context, trkIdx) {
                                          final trk = controller.tracks[trkIdx];
                                          final trackClips = controller.clips
                                              .where((c) => c.trackIndex == trk.index)
                                              .toList();
                                          return Container(
                                            height: trk.height,
                                            width: totalWidth,
                                            decoration: BoxDecoration(
                                              color: trkIdx.isEven ? t.lane : t.laneAlt,
                                              border: Border(bottom: BorderSide(color: t.line)),
                                            ),
                                            child: Stack(
                                              children: trackClips.map((clip) {
                                                return _buildClipBox(clip, trk.height);
                                              }).toList(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  left: controller.playhead * controller.zoomPixelsPerSecond,
                                  top: 0, bottom: 0,
                                  child: IgnorePointer(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 11, height: 11,
                                          decoration: BoxDecoration(
                                            color: t.playhead,
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                        ),
                                        Expanded(child: Container(width: 2, color: t.playhead)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (controller.vuMetersShown)
                  Container(
                    width: 28,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    decoration: BoxDecoration(
                      color: t.well,
                      border: Border(left: BorderSide(color: t.line)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildVuBar(controller.isPlaying ? 0.78 : 0.18),
                        _buildVuBar(controller.isPlaying ? 0.72 : 0.14),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _trayButton({
    required IconData icon, required String tooltip,
    bool active = false, bool enabled = true, required VoidCallback onTap,
  }) {
    final t = controller.theme;
    return IconButton(
      tooltip: tooltip,
      onPressed: enabled ? onTap : null,
      icon: Icon(
        icon, size: 16,
        color: !enabled ? t.fgDim.withOpacity(0.4) : active ? t.accent : t.fg,
      ),
    );
  }

  Widget _buildClipBox(TimelineClip clip, double trackHeight) {
    final t = controller.theme;
    final isSelected = controller.selectedClipId == clip.id;
    final left = clip.startTime * controller.zoomPixelsPerSecond;
    final width = math.max(28.0, clip.duration * controller.zoomPixelsPerSecond);

    Color headerColor;
    Color bodyColor;
    switch (clip.kind) {
      case ClipKind.video:
        headerColor = t.kindVideo; bodyColor = t.kindVideoWell; break;
      case ClipKind.audio:
        headerColor = t.kindAudio; bodyColor = t.kindAudioWell; break;
      case ClipKind.image:
        headerColor = t.kindImage; bodyColor = t.kindImageWell; break;
      case ClipKind.text:
        headerColor = t.kindText; bodyColor = t.kindTextWell; break;
      case ClipKind.filter:
        headerColor = t.kindFilter; bodyColor = t.kindFilterWell; break;
      case ClipKind.shape:
        headerColor = t.kindShape; bodyColor = t.kindShapeWell; break;
    }

    return Positioned(
      left: left, top: 3,
      height: trackHeight - 6, width: width,
      child: GestureDetector(
        onTap: () => controller.selectClip(clip.id),
        onHorizontalDragUpdate: (d) {
          final deltaSec = d.delta.dx / controller.zoomPixelsPerSecond;
          clip.startTime = math.max(0.0, clip.startTime + deltaSec);
          controller.selectClip(clip.id);
          controller.notifyUpdate();
        },
        child: Container(
          decoration: BoxDecoration(
            color: bodyColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isSelected ? t.accent : headerColor.withOpacity(0.7),
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 17,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                color: headerColor,
                child: Row(
                  children: [
                    if (clip.transitionName != null)
                      const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(Icons.swap_horiz, size: 11, color: Colors.white),
                      ),
                    Expanded(
                      child: Text(clip.name,
                          style: const TextStyle(color: Colors.white, fontSize: 10,
                              fontWeight: FontWeight.bold),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    if (clip.visualChain.isNotEmpty || clip.aiEnhanced)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.black38, borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Text('FX',
                            style: TextStyle(color: Color(0xFFCBF53F), fontSize: 8.5,
                                fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    children: [
                      if (clip.kind == ClipKind.text)
                        Expanded(
                          child: Text(clip.textContent,
                              style: const TextStyle(color: Color(0xFFFFE4B2), fontSize: 10),
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                        )
                      else
                        Expanded(
                          child: CustomPaint(
                            painter: _WaveformStripPainter(
                              color: clip.kind == ClipKind.audio
                                  ? const Color(0xFFA7F0C2)
                                  : const Color(0xFFA9C8F5),
                            ),
                          ),
                        ),
                      if (clip.keyframes.isNotEmpty)
                        Icon(Icons.diamond, size: 11, color: t.accent),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVuBar(double level) {
    return Container(
      width: 5,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(3),
      ),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: level.clamp(0.05, 1.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            gradient: const LinearGradient(
              colors: [Color(0xFFFF453A), Color(0xFFFFD60A), Color(0xFF34C759)],
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}

class _TimelineRulerPainter extends CustomPainter {
  final double pixelsPerSecond;
  final Color textColor;
  final Color lineColor;

  _TimelineRulerPainter({
    required this.pixelsPerSecond, required this.textColor, required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;
    final int totalSeconds = (size.width / pixelsPerSecond).ceil();
    for (int s = 0; s <= totalSeconds; s++) {
      final x = s * pixelsPerSecond;
      canvas.drawLine(Offset(x, size.height - 8), Offset(x, size.height), paint);
      final tp = TextPainter(
        text: TextSpan(
          text: '${s}s',
          style: TextStyle(color: textColor, fontSize: 9.5, fontFamily: 'monospace'),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x + 3, 4));
    }
  }

  @override
  bool shouldRepaint(covariant _TimelineRulerPainter oldDelegate) => false;
}

class _WaveformStripPainter extends CustomPainter {
  final Color color;
  _WaveformStripPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.55)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    final midY = size.height / 2;
    for (double x = 2; x < size.width - 2; x += 5) {
      final h = (math.sin(x * 0.25).abs() * 0.7 + 0.15) * (size.height * 0.42);
      canvas.drawLine(Offset(x, midY - h), Offset(x, midY + h), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformStripPainter oldDelegate) => false;
}

// ============================================================================
// 16. KEYFRAMES PANE
// ============================================================================
class YossefKeyframesPane extends StatelessWidget {
  final YossefStudioController controller;
  final VoidCallback onBackToTimeline;

  const YossefKeyframesPane({
    super.key, required this.controller, required this.onBackToTimeline,
  });

  @override
  Widget build(BuildContext context) {
    final t = controller.theme;
    final clip = controller.selectedClip;

    return Container(
      decoration: BoxDecoration(
        color: t.panel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: t.line),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.diamond_rounded, size: 16, color: t.accent),
              const SizedBox(width: 8),
              Text(controller.tr('common.keyframes'),
                  style: TextStyle(color: t.fg, fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(width: 12),
              if (clip != null)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: t.accent, foregroundColor: t.onAccent,
                    minimumSize: const Size(0, 28),
                  ),
                  onPressed: () => controller.addKeyframeToSelected('scale', 0.65),
                  icon: const Icon(Icons.add, size: 14),
                  label: Text(controller.isArabic ? 'إضافة إطار مفتاحي' : 'Add Keyframe',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: onBackToTimeline,
                icon: const Icon(Icons.view_stream_rounded, size: 14),
                label: Text(controller.isArabic ? 'العودة للمخطط' : 'Back to Timeline',
                    style: const TextStyle(fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: clip == null
                ? Center(
                    child: Text(
                      controller.isArabic ? 'اختر مقطعاً لتحرير الإطارات' : 'Select a clip',
                      style: TextStyle(color: t.fgMuted),
                    ),
                  )
                : Row(
                    children: [
                      SizedBox(
                        width: 240,
                        child: ListView(
                          children: clip.keyframes.map((k) {
                            return ListTile(
                              dense: true,
                              leading: Icon(Icons.diamond, size: 14, color: t.accent),
                              title: Text(
                                '${k.property.toUpperCase()} · ${(k.value * 100).toStringAsFixed(0)}%',
                                style: TextStyle(color: t.fg, fontSize: 11.5,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('@ ${k.timeOffset.toStringAsFixed(2)}s · ${k.easing}',
                                  style: TextStyle(color: t.fgDim, fontSize: 10)),
                              trailing: IconButton(
                                icon: Icon(Icons.close, size: 14, color: t.danger),
                                onPressed: () {
                                  clip.keyframes.remove(k);
                                  controller.notifyUpdate();
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: t.well,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: t.line),
                          ),
                          child: CustomPaint(
                            painter: _BezierCurveEditorPainter(
                              accent: t.accent, points: clip.keyframes,
                              clipDuration: clip.duration,
                            ),
                            child: const Center(),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _BezierCurveEditorPainter extends CustomPainter {
  final Color accent;
  final List<KeyframePoint> points;
  final double clipDuration;

  _BezierCurveEditorPainter({
    required this.accent, required this.points, required this.clipDuration,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = accent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    if (points.isEmpty) return;
    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final px = (points[i].timeOffset / math.max(1.0, clipDuration)).clamp(0.0, 1.0) * size.width;
      final py = (1.0 - points[i].value.clamp(0.0, 1.0)) * (size.height - 24) + 12;
      if (i == 0) path.moveTo(px, py);
      else path.lineTo(px, py);
      canvas.drawCircle(Offset(px, py), 5, Paint()..color = accent);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BezierCurveEditorPainter oldDelegate) => true;
}

// ============================================================================
// 17. PHONE EDITOR
// ============================================================================
class YossefPhoneEditor extends StatefulWidget {
  final YossefStudioController controller;
  final void Function({int initialTab}) onOpenSettings;
  final VoidCallback onOpenExport;
  final VoidCallback onOpenCaptions;
  final VoidCallback onOpenSpeech;
  final VoidCallback onOpenVoiceover;

  const YossefPhoneEditor({
    super.key, required this.controller,
    required this.onOpenSettings, required this.onOpenExport,
    required this.onOpenCaptions, required this.onOpenSpeech, required this.onOpenVoiceover,
  });

  @override
  State<YossefPhoneEditor> createState() => _YossefPhoneEditorState();
}

class _YossefPhoneEditorState extends State<YossefPhoneEditor> {
  int bottomSheetTab = -1;
  YossefStudioController get c => widget.controller;
  YossefThemeData get t => c.theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 48,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: YossefPreviewPane(controller: c, bare: true),
          ),
        ),
        Expanded(
          flex: 42,
          child: bottomSheetTab == 0
              ? YossefLibraryPane(
                  controller: c,
                  onOpenCaptions: widget.onOpenCaptions,
                  onOpenSpeech: widget.onOpenSpeech,
                  onOpenVoiceover: widget.onOpenVoiceover,
                )
              : bottomSheetTab == 1
                  ? YossefInspectorPane(controller: c, onOpenSettings: widget.onOpenSettings)
                  : YossefTimelinePane(
                      controller: c,
                      onOpenKeyframes: () => setState(() => bottomSheetTab = 1),
                      onOpenCaptions: widget.onOpenCaptions,
                      onOpenSpeech: widget.onOpenSpeech,
                      onOpenVoiceover: widget.onOpenVoiceover,
                    ),
        ),
        Container(
          height: 66,
          decoration: BoxDecoration(
            color: t.panel,
            border: Border(top: BorderSide(color: t.line)),
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              _phoneToolItem(
                icon: Icons.view_timeline_rounded,
                label: c.tr('common.timeline'),
                active: bottomSheetTab == -1,
                onTap: () => setState(() => bottomSheetTab = -1),
              ),
              _phoneToolItem(
                icon: Icons.video_library_rounded,
                label: c.tr('common.library'),
                active: bottomSheetTab == 0,
                onTap: () => setState(() => bottomSheetTab = bottomSheetTab == 0 ? -1 : 0),
              ),
              _phoneToolItem(
                icon: Icons.tune_rounded,
                label: c.tr('common.inspector'),
                active: bottomSheetTab == 1,
                onTap: () => setState(() => bottomSheetTab = bottomSheetTab == 1 ? -1 : 1),
              ),
              _phoneToolItem(
                icon: Icons.content_cut_rounded,
                label: c.tr('common.split'),
                onTap: c.splitSelectedOrAtPlayhead,
              ),
              _phoneToolItem(
                icon: Icons.closed_caption_rounded,
                label: c.tr('common.captions'),
                onTap: widget.onOpenCaptions,
              ),
              _phoneToolItem(
                icon: Icons.record_voice_over_rounded,
                label: c.tr('common.speech'),
                onTap: widget.onOpenSpeech,
              ),
              _phoneToolItem(
                icon: Icons.settings_suggest_rounded,
                label: c.tr('common.settings'),
                onTap: () => widget.onOpenSettings(initialTab: 7),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _phoneToolItem({
    required IconData icon, required String label,
    bool active = false, required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 74,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: active ? t.accent : t.fg),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                  color: active ? t.accent : t.fgMuted,
                  fontSize: 10,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                ),
                maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 18. SETTINGS DIALOG
// ============================================================================
class YossefSettingsDialog extends StatefulWidget {
  final YossefStudioController controller;
  final int initialTab;

  const YossefSettingsDialog({
    super.key, required this.controller, this.initialTab = 0,
  });

  @override
  State<YossefSettingsDialog> createState() => _YossefSettingsDialogState();
}

class _YossefSettingsDialogState extends State<YossefSettingsDialog> {
  late int currentTab;

  YossefStudioController get c => widget.controller;
  YossefThemeData get t => c.theme;

  @override
  void initState() {
    super.initState();
    currentTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      (0, Icons.settings_outlined, c.tr('settings.general')),
      (1, Icons.palette_outlined, c.tr('settings.appearance')),
      (2, Icons.closed_caption_outlined, c.tr('settings.transcriber')),
      (3, Icons.record_voice_over_outlined, c.tr('settings.speech')),
      (4, Icons.hd_outlined, c.tr('settings.vision')),
      (5, Icons.hub_outlined, c.tr('settings.automation')),
      (6, Icons.keyboard_outlined, c.tr('settings.shortcuts')),
      (7, Icons.verified_user_rounded, c.tr('settings.developer')),
    ];

    return Dialog(
      backgroundColor: t.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: t.lineStrong),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 780, maxHeight: 560),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: t.line))),
              child: Row(
                children: [
                  Icon(Icons.settings_suggest_rounded, color: t.accent, size: 20),
                  const SizedBox(width: 8),
                  Text('${c.tr('common.settings')} · YOSSEF STUDIO PRO',
                      style: TextStyle(color: t.fg, fontSize: 15, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: t.fgMuted, size: 18),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 215,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: t.well,
                      border: Border(
                        right: c.isArabic ? BorderSide.none : BorderSide(color: t.line),
                        left: c.isArabic ? BorderSide(color: t.line) : BorderSide.none,
                      ),
                    ),
                    child: ListView(
                      children: tabs.map((item) {
                        final selected = currentTab == item.$1;
                        final isDevTab = item.$1 == 7;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: InkWell(
                            onTap: () => setState(() => currentTab = item.$1),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                              decoration: BoxDecoration(
                                color: selected
                                    ? t.accent
                                    : isDevTab ? t.accentSoft : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(item.$2, size: 16,
                                      color: selected
                                          ? t.onAccent
                                          : isDevTab ? t.accent : t.fgMuted),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(item.$3,
                                        style: TextStyle(
                                          color: selected
                                              ? t.onAccent
                                              : isDevTab ? t.accent : t.fg,
                                          fontSize: 12,
                                          fontWeight: selected || isDevTab
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: _buildSettingsPage(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsPage(BuildContext context) {
    switch (currentTab) {
      case 0: return _buildGeneralPage();
      case 1: return _buildAppearancePage();
      case 2: return _buildModelsPage('whisper', 'Whisper AI Transcriber Models');
      case 3: return _buildModelsPage('tts', 'Neural TTS & Voice Cloning Models');
      case 4: return _buildModelsPage('vision', 'AI Cutout & 8K Super-Resolution');
      case 5: return _buildAutomationPage();
      case 6: return _buildShortcutsPage();
      case 7:
      default: return _buildDeveloperPage(context);
    }
  }

  Widget _buildDeveloperPage(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [t.accent.withOpacity(0.22), t.raised],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: t.accent, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 54, height: 54,
                    decoration: BoxDecoration(color: t.accent, shape: BoxShape.circle),
                    child: Icon(Icons.verified_user_rounded, size: 30, color: t.onAccent),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.tr('dev.title'),
                            style: TextStyle(color: t.accent, fontSize: 13,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('المطور: يوسف حامد (YOSSEF HAMED)',
                            style: TextStyle(color: t.fg, fontSize: 20,
                                fontWeight: FontWeight.w900)),
                        Text(YossefBrand.copyright,
                            style: TextStyle(color: t.fgMuted, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: t.well,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: t.green.withOpacity(0.6)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.chat_rounded, color: t.green, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('التواصل المباشر عبر واتساب',
                              style: TextStyle(color: t.fgMuted, fontSize: 11.5)),
                          const SizedBox(height: 2),
                          SelectableText(YossefBrand.whatsappNumber,
                              style: TextStyle(
                                color: t.green, fontSize: 22,
                                fontWeight: FontWeight.w900, letterSpacing: 1.2,
                              )),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: t.green, foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      ),
                      onPressed: () {
                        Clipboard.setData(const ClipboardData(text: YossefBrand.whatsappNumber));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: t.green,
                            content: Text(c.tr('dev.phoneCopied'),
                                style: const TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded, size: 16),
                      label: Text(c.isArabic ? 'نسخ الرقم' : 'Copy Number',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoTile('اسم التطبيق', YossefBrand.appName),
        _buildInfoTile('المطور الرئيسي', 'يوسف حامد (Yossef Hamed)'),
        _buildInfoTile('رقم واتساب', '01029892573 (${YossefBrand.whatsappUrl})'),
        _buildInfoTile('حقوق الملكية', 'جميع الحقوق محفوظة لـ YOSSEF © 2026'),
        _buildInfoTile('محرك المعالجة', YossefBrand.engineName),
      ],
    );
  }

  Widget _buildInfoTile(String label, String value) {
    final t = c.theme; // تم إصلاح الخطأ هنا باستخدام c بدلاً من controller
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: t.raised,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: t.line),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: t.fgMuted, fontSize: 12)),
          Flexible(
            child: SelectableText(value,
                style: TextStyle(color: t.fg, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralPage() {
    return ListView(
      children: [
        Text(c.tr('settings.general'),
            style: TextStyle(color: t.fg, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SwitchListTile(
          activeColor: t.accent,
          title: Text(c.isArabic ? 'الواجهة العربية (RTL)' : 'Arabic Interface (RTL)',
              style: TextStyle(color: t.fg, fontSize: 13)),
          value: c.isArabic,
          onChanged: (v) {
            setState(() => c.isArabic = v);
            c.notifyUpdate();
          },
        ),
        SwitchListTile(
          activeColor: t.accent,
          title: Text(c.isArabic ? 'التسريع العتادي للـ GPU' : 'GPU Hardware Acceleration',
              style: TextStyle(color: t.fg, fontSize: 13)),
          subtitle: Text('Vulkan / Metal / Direct3D 12 · 10-bit HDR',
              style: TextStyle(color: t.fgDim, fontSize: 11)),
          value: c.gpuHardwareAcceleration,
          onChanged: (v) {
            setState(() => c.gpuHardwareAcceleration = v);
            c.notifyUpdate();
          },
        ),
        SwitchListTile(
          activeColor: t.accent,
          title: Text(c.isArabic ? 'المخطط المغناطيسي' : 'Magnetic Timeline',
              style: TextStyle(color: t.fg, fontSize: 13)),
          value: c.magneticTimeline,
          onChanged: (v) {
            setState(() => c.magneticTimeline = v);
            c.notifyUpdate();
          },
        ),
        SwitchListTile(
          activeColor: t.accent,
          title: Text(c.isArabic ? 'ملفات Proxy ذكية' : 'Smart Background Proxies',
              style: TextStyle(color: t.fg, fontSize: 13)),
          value: c.smartProxies,
          onChanged: (v) {
            setState(() => c.smartProxies = v);
            c.notifyUpdate();
          },
        ),
        SwitchListTile(
          activeColor: t.accent,
          title: Text(c.isArabic ? 'معالجة 10-bit HDR' : '10-bit HDR Pipeline',
              style: TextStyle(color: t.fg, fontSize: 13)),
          value: c.tenBitHdrPipeline,
          onChanged: (v) {
            setState(() => c.tenBitHdrPipeline = v);
            c.notifyUpdate();
          },
        ),
        SwitchListTile(
          activeColor: t.accent,
          title: Text(c.isArabic ? 'إيقاف المؤشر في النهاية' : 'Stop Playhead at End',
              style: TextStyle(color: t.fg, fontSize: 13)),
          value: c.playheadStopsAtEnd,
          onChanged: (v) {
            setState(() => c.playheadStopsAtEnd = v);
            c.notifyUpdate();
          },
        ),
        SwitchListTile(
          activeColor: t.accent,
          title: Text(c.isArabic ? 'مقاييس VU' : 'VU Meters',
              style: TextStyle(color: t.fg, fontSize: 13)),
          value: c.vuMetersShown,
          onChanged: (v) {
            setState(() => c.vuMetersShown = v);
            c.notifyUpdate();
          },
        ),
      ],
    );
  }

  Widget _buildAppearancePage() {
    return ListView(
      children: [
        Text(c.tr('settings.appearance'),
            style: TextStyle(color: t.fg, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SwitchListTile(
          activeColor: t.accent,
          title: Text(c.isArabic ? 'الوضع الليلي' : 'Dark Theme',
              style: TextStyle(color: t.fg, fontSize: 13)),
          value: t.dark,
          onChanged: (v) {
            setState(() => c.theme = t.copyWith(dark: v));
            c.notifyUpdate();
          },
        ),
        const SizedBox(height: 12),
        Text(c.isArabic ? 'اللون المميز' : 'Accent Color',
            style: TextStyle(color: t.fgMuted, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12, runSpacing: 12,
          children: List.generate(YossefThemeData.darkAccents.length, (idx) {
            final acc = YossefThemeData.darkAccents[idx];
            final chosen = t.accentChoice == idx;
            return InkWell(
              onTap: () {
                setState(() => c.theme = t.copyWith(accentChoice: idx));
                c.notifyUpdate();
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: t.raised,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: chosen ? acc.accent : t.line,
                    width: chosen ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 16, height: 16,
                        decoration: BoxDecoration(color: acc.accent, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text(c.isArabic ? acc.nameAr : acc.nameEn,
                        style: TextStyle(color: t.fg, fontSize: 12)),
                  ],
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Text(c.isArabic ? 'حجم الواجهة' : 'Interface Scale',
            style: TextStyle(color: t.fgMuted, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            (0, 'System'),
            (2, '110%'),
            (3, '125%'),
            (4, '140%'),
          ].map((scale) {
            return ChoiceChip(
              label: Text(scale.$2),
              selected: t.uiScaleIndex == scale.$1,
              selectedColor: t.accent,
              onSelected: (_) {
                setState(() => c.theme = t.copyWith(uiScaleIndex: scale.$1));
                c.notifyUpdate();
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildModelsPage(String family, String heading) {
    final models = c.aiModels.where((m) => m.family == family).toList();
    return ListView(
      children: [
        Text(heading, style: TextStyle(color: t.fg, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(c.isArabic
            ? 'جميع النماذج تعمل محلياً 100% على جهازك.'
            : 'All AI models run 100% locally on your hardware.',
            style: TextStyle(color: t.fgMuted, fontSize: 12)),
        const SizedBox(height: 12),
        ...models.map((m) {
          return Card(
            color: m.active ? t.accentSoft : t.raised,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: m.active ? t.accent : t.line),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(m.name,
                        style: TextStyle(color: t.fg, fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  Text(m.sizeText,
                      style: TextStyle(color: t.accent, fontSize: 11, fontFamily: 'monospace')),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(m.note, style: TextStyle(color: t.fgMuted, fontSize: 11.5)),
              ),
              trailing: m.installed
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: m.active ? t.accent : t.field,
                        foregroundColor: m.active ? t.onAccent : t.fg,
                      ),
                      onPressed: () {
                        for (final other in models) {
                          other.active = false;
                        }
                        setState(() => m.active = true);
                        c.notifyUpdate();
                      },
                      child: Text(
                        m.active
                            ? (c.isArabic ? 'مُفعّل ✓' : 'Active ✓')
                            : (c.isArabic ? 'تفعيل' : 'Activate'),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    )
                  : OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          m.installed = true;
                          m.active = true;
                        });
                        c.notifyUpdate();
                      },
                      icon: const Icon(Icons.download_rounded, size: 15),
                      label: Text(c.isArabic ? 'تنزيل' : 'Download',
                          style: const TextStyle(fontSize: 11)),
                    ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAutomationPage() {
    return ListView(
      children: [
        Text(c.tr('settings.automation'),
            style: TextStyle(color: t.fg, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SwitchListTile(
          activeColor: t.accent,
          title: Text(c.isArabic ? 'تفعيل خادم MCP & JSON-RPC' : 'Enable MCP & JSON-RPC Server',
              style: TextStyle(color: t.fg, fontSize: 13)),
          subtitle: Text('${c.mcpServerHost}:${c.mcpServerPort} · Token: ${c.mcpServerToken}',
              style: TextStyle(color: t.green, fontSize: 11.5)),
          value: c.mcpServerEnabled,
          onChanged: (v) {
            setState(() => c.mcpServerEnabled = v);
            c.notifyUpdate();
          },
        ),
      ],
    );
  }

  Widget _buildShortcutsPage() {
    final shortcuts = [
      ('Play / Pause', 'Space'),
      ('Split at Playhead', 'S'),
      ('Delete Selected', 'Delete'),
      ('Duplicate', 'Ctrl + D'),
      ('Undo', 'Ctrl + Z'),
      ('Redo', 'Ctrl + Shift + Z'),
      ('Step Frame', '← / →'),
      ('Stop', 'K'),
    ];
    return ListView(
      children: [
        Text(c.tr('settings.shortcuts'),
            style: TextStyle(color: t.fg, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...shortcuts.map((s) {
          return Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: t.raised, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(s.$1, style: TextStyle(color: t.fg, fontSize: 12)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: t.fieldActive, borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(s.$2,
                      style: TextStyle(color: t.accent, fontSize: 11, fontFamily: 'monospace')),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

// ============================================================================
// 19. NEW PROJECT DIALOG
// ============================================================================
class YossefNewProjectDialog extends StatefulWidget {
  final YossefStudioController controller;
  const YossefNewProjectDialog({super.key, required this.controller});
  @override
  State<YossefNewProjectDialog> createState() => _YossefNewProjectDialogState();
}

class _YossefNewProjectDialogState extends State<YossefNewProjectDialog> {
  late TextEditingController _nameCtrl;
  int selectedAspect = 0;
  int selectedRes = 3;
  double selectedFps = 60.0;

  YossefStudioController get c => widget.controller;
  YossefThemeData get t => c.theme;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: 'مشروع YOSSEF الجديد');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aspects = ['16:9', '9:16', '1:1', '4:5', '21:9'];
    final resolutions = ['720p', '1080p', '4K UHD', '8K Master'];
    final rates = [24.0, 25.0, 30.0, 50.0, 60.0, 120.0, 240.0];

    return Dialog(
      backgroundColor: t.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: t.lineStrong),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.add_box_rounded, color: t.accent),
                  const SizedBox(width: 8),
                  Text(c.tr('start.newProject'),
                      style: TextStyle(color: t.fg, fontSize: 17, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameCtrl,
                style: TextStyle(color: t.fg),
                decoration: InputDecoration(
                  labelText: c.tr('common.name'),
                  filled: true, fillColor: t.field,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 14),
              Text(c.tr('common.shape'),
                  style: TextStyle(color: t.fgMuted, fontSize: 12)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: List.generate(aspects.length, (i) {
                  return ChoiceChip(
                    label: Text(aspects[i], style: const TextStyle(fontSize: 11)),
                    selected: selectedAspect == i,
                    selectedColor: t.accent,
                    onSelected: (_) => setState(() => selectedAspect = i),
                  );
                }),
              ),
              const SizedBox(height: 14),
              Text(c.tr('common.size'), style: TextStyle(color: t.fgMuted, fontSize: 12)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: List.generate(resolutions.length, (i) {
                  return ChoiceChip(
                    label: Text(resolutions[i], style: const TextStyle(fontSize: 11)),
                    selected: selectedRes == i,
                    selectedColor: t.accent,
                    onSelected: (_) => setState(() => selectedRes = i),
                  );
                }),
              ),
              const SizedBox(height: 14),
              Text(c.tr('common.frameRate'),
                  style: TextStyle(color: t.fgMuted, fontSize: 12)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                children: rates.map((fps) {
                  return ChoiceChip(
                    label: Text('${fps.toInt()} FPS', style: const TextStyle(fontSize: 11)),
                    selected: selectedFps == fps,
                    selectedColor: t.accent,
                    onSelected: (_) => setState(() => selectedFps = fps),
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(c.tr('common.cancel'),
                        style: TextStyle(color: t.fgMuted)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: t.accent, foregroundColor: t.onAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    onPressed: () {
                      c.projectName = _nameCtrl.text.trim().isEmpty
                          ? 'YOSSEF Ultra Project'
                          : _nameCtrl.text.trim();
                      c.frameRate = selectedFps;
                      if (selectedRes == 3) {
                        c.outputWidth = selectedAspect == 1 ? 4320 : 7680;
                        c.outputHeight = selectedAspect == 1 ? 7680 : 4320;
                      } else if (selectedRes == 2) {
                        c.outputWidth = selectedAspect == 1 ? 2160 : 3840;
                        c.outputHeight = selectedAspect == 1 ? 3840 : 2160;
                      } else {
                        c.outputWidth = selectedAspect == 1 ? 1080 : 1920;
                        c.outputHeight = selectedAspect == 1 ? 1920 : 1080;
                      }
                      c.onStartScreen = false;
                      c.notifyUpdate();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.check_circle_outline, size: 18),
                    label: Text(c.tr('common.create'),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 20. EXPORT DIALOG
// ============================================================================
class YossefExportDialog extends StatefulWidget {
  final YossefStudioController controller;
  const YossefExportDialog({super.key, required this.controller});
  @override
  State<YossefExportDialog> createState() => _YossefExportDialogState();
}

class _YossefExportDialogState extends State<YossefExportDialog> {
  Timer? _exportTimer;
  bool exportDone = false;

  YossefStudioController get c => widget.controller;
  YossefThemeData get t => c.theme;

  void _startSimulatedExport() {
    setState(() {
      c.isExporting = true;
      c.exportProgress = 0.0;
      exportDone = false;
    });
    _exportTimer?.cancel();
    _exportTimer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      setState(() {
        c.exportProgress += 0.05;
        if (c.exportProgress >= 1.0) {
          c.exportProgress = 1.0;
          c.isExporting = false;
          exportDone = true;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _exportTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final codecs = ['H.264', 'HEVC / H.265', 'AV1 Ultra'];
    final resolutions = ['720p', '1080p', '4K UHD', '8K Master'];

    return Dialog(
      backgroundColor: t.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: t.lineStrong),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.ios_share_rounded, color: t.accent),
                  const SizedBox(width: 8),
                  Text('${c.tr('common.export')} · YOSSEF ULTRA',
                      style: TextStyle(color: t.fg, fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: t.fgMuted),
                  ),
                ],
              ),
              const Divider(height: 20),
              Text(c.isArabic ? 'الدقة' : 'Resolution',
                  style: TextStyle(color: t.fgMuted, fontSize: 12)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: List.generate(resolutions.length, (i) {
                  return ChoiceChip(
                    label: Text(resolutions[i], style: const TextStyle(fontSize: 11)),
                    selected: c.exportResolutionIndex == i,
                    selectedColor: t.accent,
                    onSelected: (_) => setState(() => c.exportResolutionIndex = i),
                  );
                }),
              ),
              const SizedBox(height: 14),
              Text(c.isArabic ? 'الترميز' : 'Codec',
                  style: TextStyle(color: t.fgMuted, fontSize: 12)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: List.generate(codecs.length, (i) {
                  return ChoiceChip(
                    label: Text(codecs[i], style: const TextStyle(fontSize: 11)),
                    selected: c.exportCodecIndex == i,
                    selectedColor: t.accent,
                    onSelected: (_) => setState(() => c.exportCodecIndex = i),
                  );
                }),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                dense: true, contentPadding: EdgeInsets.zero, activeColor: t.accent,
                title: Text(c.isArabic ? '10-bit HDR10' : '10-bit HDR',
                    style: TextStyle(color: t.fg, fontSize: 12.5)),
                value: c.exportTenBit,
                onChanged: (v) => setState(() => c.exportTenBit = v),
              ),
              Row(
                children: [
                  Text('Bitrate: ${c.exportBitrateMbps.toStringAsFixed(0)} Mbps',
                      style: TextStyle(color: t.fg, fontSize: 12, fontFamily: 'monospace')),
                  Expanded(
                    child: Slider(
                      value: c.exportBitrateMbps, min: 10, max: 240,
                      activeColor: t.accent,
                      onChanged: (v) => setState(() => c.exportBitrateMbps = v),
                    ),
                  ),
                ],
              ),
              if (c.isExporting) ...[
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: c.exportProgress,
                  backgroundColor: t.field, color: t.accent, minHeight: 8,
                ),
                const SizedBox(height: 6),
                Text('${(c.exportProgress * 100).toInt()}% · YOSSEF GPU Export...',
                    style: TextStyle(color: t.accent, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
              if (exportDone)
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: t.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: t.green),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: t.green, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          c.isArabic
                              ? 'تم التصدير بنجاح بدون علامة مائية!'
                              : 'Export completed with zero watermark!',
                          style: TextStyle(color: t.green, fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: t.accent, foregroundColor: t.onAccent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: c.isExporting ? null : _startSimulatedExport,
                  icon: const Icon(Icons.bolt_rounded),
                  label: Text(
                    c.isArabic ? 'بدء التصدير' : 'Start Ultra Export',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 21. AI DIALOGS
// ============================================================================
class YossefCaptionsDialog extends StatefulWidget {
  final YossefStudioController controller;
  const YossefCaptionsDialog({super.key, required this.controller});
  @override
  State<YossefCaptionsDialog> createState() => _YossefCaptionsDialogState();
}

class _YossefCaptionsDialogState extends State<YossefCaptionsDialog> {
  final _scriptCtrl = TextEditingController(
    text: 'مرحباً بكم في استوديو YOSSEF الاحترافي\nالمطور يوسف حامد - واتساب 01029892573',
  );

  @override
  void dispose() {
    _scriptCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.controller;
    final t = c.theme;
    return AlertDialog(
      backgroundColor: t.panel,
      title: Text(c.tr('common.captions'),
          style: TextStyle(color: t.fg, fontSize: 16)),
      content: SizedBox(
        width: 440,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(c.isArabic
                ? 'توليد عناوين متزامنة مع الصوت:'
                : 'Generate timed captions:',
                style: TextStyle(color: t.fgMuted, fontSize: 12)),
            const SizedBox(height: 10),
            TextField(
              controller: _scriptCtrl, maxLines: 4,
              style: TextStyle(color: t.fg, fontSize: 12.5),
              decoration: InputDecoration(
                filled: true, fillColor: t.field,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(c.tr('common.cancel'), style: TextStyle(color: t.fgMuted)),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: t.accent, foregroundColor: t.onAccent),
          onPressed: () {
            c.generateAutoCaptions(_scriptCtrl.text);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.auto_awesome, size: 16),
          label: Text(c.isArabic ? 'توليد' : 'Generate'),
        ),
      ],
    );
  }
}

class YossefSpeechDialog extends StatefulWidget {
  final YossefStudioController controller;
  const YossefSpeechDialog({super.key, required this.controller});
  @override
  State<YossefSpeechDialog> createState() => _YossefSpeechDialogState();
}

class _YossefSpeechDialogState extends State<YossefSpeechDialog> {
  final _ttsCtrl = TextEditingController(
    text: 'تم تطوير هذا التطبيق بحقوق YOSSEF بواسطة يوسف حامد.',
  );
  String selectedVoice = 'YOSSEF Studio Arabic Pro';

  @override
  void dispose() {
    _ttsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.controller;
    final t = c.theme;
    final voices = [
      'YOSSEF Studio Arabic Pro',
      'Kokoro Neural Warm',
      'Pocket Zero-Shot Cloned Voice',
      'Chatterbox Expressive Cinema',
    ];

    return AlertDialog(
      backgroundColor: t.panel,
      title: Text(c.tr('common.speech'),
          style: TextStyle(color: t.fg, fontSize: 16)),
      content: SizedBox(
        width: 440,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedVoice,
              dropdownColor: t.raised,
              style: TextStyle(color: t.fg, fontSize: 12.5),
              items: voices.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
              onChanged: (v) {
                if (v != null) setState(() => selectedVoice = v);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ttsCtrl, maxLines: 4,
              style: TextStyle(color: t.fg, fontSize: 12.5),
              decoration: InputDecoration(
                filled: true, fillColor: t.field,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(c.tr('common.cancel'), style: TextStyle(color: t.fgMuted)),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: t.accent, foregroundColor: t.onAccent),
          onPressed: () {
            c.generateSpeechClip(_ttsCtrl.text, selectedVoice);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.graphic_eq_rounded, size: 16),
          label: Text(c.isArabic ? 'توليد الصوت' : 'Synthesize'),
        ),
      ],
    );
  }
}

class YossefVoiceoverDialog extends StatelessWidget {
  final YossefStudioController controller;
  const YossefVoiceoverDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = controller.theme;
    return AlertDialog(
      backgroundColor: t.panel,
      title: Text(controller.tr('common.voiceover'),
          style: TextStyle(color: t.fg, fontSize: 16)),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: t.well, borderRadius: BorderRadius.circular(8),
              ),
              child: Text(controller.teleprompterText,
                  style: TextStyle(color: t.fg, fontSize: 13, height: 1.5)),
            ),
            const SizedBox(height: 14),
            Icon(Icons.mic_rounded, size: 42, color: t.danger),
            const SizedBox(height: 6),
            Text(
              controller.isArabic
                  ? 'تسجيل تعليق صوتي بجودة استوديو 48kHz 24-bit'
                  : 'Studio 48kHz 24-bit Voiceover Recorder',
              style: TextStyle(color: t.fgMuted, fontSize: 11.5),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(controller.tr('common.cancel'), style: TextStyle(color: t.fgMuted)),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: t.danger, foregroundColor: Colors.white),
          onPressed: () {
            controller.generateSpeechClip(controller.teleprompterText, 'Studio Mic Take');
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.fiber_manual_record_rounded, size: 16),
          label: Text(controller.isArabic ? 'تسجيل' : 'Record'),
        ),
      ],
    );
  }
}
