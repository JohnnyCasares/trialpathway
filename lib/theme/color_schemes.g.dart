import 'package:flutter/material.dart';

class CustomTheme {
  // final TextTheme textTheme;
  //
  // const CustomTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4284374871),
      surfaceTint: Color(4284374871),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4294901234),
      onPrimaryContainer: Color(4283914063),
      secondary: Color(4284440154),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4293321694),
      onSecondaryContainer: Color(4282992965),
      tertiary: Color(4284112735),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294573821),
      onTertiaryContainer: Color(4283586648),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294768887),
      onBackground: Color(4280032027),
      surface: Color(4294768887),
      onSurface: Color(4280032027),
      surfaceVariant: Color(4293190617),
      onSurfaceVariant: Color(4282861377),
      outline: Color(4286019440),
      outlineVariant: Color(4291348414),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281413679),
      inverseOnSurface: Color(4294242542),
      inversePrimary: Color(4291282877),
      primaryFixed: Color(4293190616),
      onPrimaryFixed: Color(4279966742),
      primaryFixedDim: Color(4291282877),
      onPrimaryFixedVariant: Color(4282795840),
      secondaryFixed: Color(4293255901),
      onSecondaryFixed: Color(4279966745),
      secondaryFixedDim: Color(4291348161),
      onSecondaryFixedVariant: Color(4282861379),
      tertiaryFixed: Color(4292797411),
      onTertiaryFixed: Color(4279704860),
      tertiaryFixedDim: Color(4290955463),
      onTertiaryFixedVariant: Color(4282533959),
      surfaceDim: Color(4292729304),
      surfaceBright: Color(4294768887),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294439921),
      surfaceContainer: Color(4294045163),
      surfaceContainerHigh: Color(4293650406),
      surfaceContainerHighest: Color(4293255904),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4282532668),
      surfaceTint: Color(4284374871),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4285887852),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282598207),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285887856),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282270788),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4285560437),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294768887),
      onBackground: Color(4280032027),
      surface: Color(4294768887),
      onSurface: Color(4280032027),
      surfaceVariant: Color(4293190617),
      onSurfaceVariant: Color(4282598205),
      outline: Color(4284440664),
      outlineVariant: Color(4286282611),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281413679),
      inverseOnSurface: Color(4294242542),
      inversePrimary: Color(4291282877),
      primaryFixed: Color(4285887852),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4284243284),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285887856),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4284308568),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4285560437),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4283915613),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292729304),
      surfaceBright: Color(4294768887),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294439921),
      surfaceContainer: Color(4294045163),
      surfaceContainerHigh: Color(4293650406),
      surfaceContainerHighest: Color(4293255904),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4280427292),
      surfaceTint: Color(4284374871),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282532668),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280427039),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282598207),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4280165155),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4282270788),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294768887),
      onBackground: Color(4280032027),
      surface: Color(4294768887),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4293190617),
      onSurfaceVariant: Color(4280493087),
      outline: Color(4282598205),
      outlineVariant: Color(4282598205),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281413679),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4293782754),
      primaryFixed: Color(4282532668),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281085222),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282598207),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4281150761),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4282270788),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4280823341),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292729304),
      surfaceBright: Color(4294768887),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294439921),
      surfaceContainer: Color(4294045163),
      surfaceContainerHigh: Color(4293650406),
      surfaceContainerHighest: Color(4293255904),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294967295),
      surfaceTint: Color(4291282877),
      onPrimary: Color(4281348394),
      primaryContainer: Color(4292203978),
      onPrimaryContainer: Color(4282335288),
      secondary: Color(4291348161),
      onSecondary: Color(4281413933),
      secondaryContainer: Color(4282203450),
      onSecondaryContainer: Color(4292071627),
      tertiary: Color(4294967295),
      onTertiary: Color(4281086257),
      tertiaryContainer: Color(4291876309),
      onTertiaryContainer: Color(4282073152),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279505683),
      onBackground: Color(4293255904),
      surface: Color(4279505683),
      onSurface: Color(4293255904),
      surfaceVariant: Color(4282861377),
      onSurfaceVariant: Color(4291348414),
      outline: Color(4287730057),
      outlineVariant: Color(4282861377),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293255904),
      inverseOnSurface: Color(4281413679),
      inversePrimary: Color(4284374871),
      primaryFixed: Color(4293190616),
      onPrimaryFixed: Color(4279966742),
      primaryFixedDim: Color(4291282877),
      onPrimaryFixedVariant: Color(4282795840),
      secondaryFixed: Color(4293255901),
      onSecondaryFixed: Color(4279966745),
      secondaryFixedDim: Color(4291348161),
      onSecondaryFixedVariant: Color(4282861379),
      tertiaryFixed: Color(4292797411),
      onTertiaryFixed: Color(4279704860),
      tertiaryFixedDim: Color(4290955463),
      onTertiaryFixedVariant: Color(4282533959),
      surfaceDim: Color(4279505683),
      surfaceBright: Color(4282005816),
      surfaceContainerLowest: Color(4279111181),
      surfaceContainerLow: Color(4280032027),
      surfaceContainer: Color(4280295199),
      surfaceContainerHigh: Color(4280953385),
      surfaceContainerHighest: Color(4281677108),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294967295),
      surfaceTint: Color(4291282877),
      onPrimary: Color(4281348394),
      primaryContainer: Color(4292203978),
      onPrimaryContainer: Color(4280229914),
      secondary: Color(4291676869),
      onSecondary: Color(4279637524),
      secondaryContainer: Color(4287795596),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294967295),
      onTertiary: Color(4281086257),
      tertiaryContainer: Color(4291876309),
      onTertiaryContainer: Color(4279967776),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279505683),
      onBackground: Color(4293255904),
      surface: Color(4279505683),
      onSurface: Color(4294900472),
      surfaceVariant: Color(4282861377),
      onSurfaceVariant: Color(4291611586),
      outline: Color(4288979867),
      outlineVariant: Color(4286809212),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293255904),
      inverseOnSurface: Color(4281018921),
      inversePrimary: Color(4282927425),
      primaryFixed: Color(4293190616),
      onPrimaryFixed: Color(4279243276),
      primaryFixedDim: Color(4291282877),
      onPrimaryFixedVariant: Color(4281743152),
      secondaryFixed: Color(4293255901),
      onSecondaryFixed: Color(4279308558),
      secondaryFixedDim: Color(4291348161),
      onSecondaryFixedVariant: Color(4281742899),
      tertiaryFixed: Color(4292797411),
      onTertiaryFixed: Color(4279046674),
      tertiaryFixedDim: Color(4290955463),
      onTertiaryFixedVariant: Color(4281481015),
      surfaceDim: Color(4279505683),
      surfaceBright: Color(4282005816),
      surfaceContainerLowest: Color(4279111181),
      surfaceContainerLow: Color(4280032027),
      surfaceContainer: Color(4280295199),
      surfaceContainerHigh: Color(4280953385),
      surfaceContainerHighest: Color(4281677108),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294967295),
      surfaceTint: Color(4291282877),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4292203978),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294834933),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4291676869),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294967295),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4291876309),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279505683),
      onBackground: Color(4293255904),
      surface: Color(4279505683),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282861377),
      onSurfaceVariant: Color(4294769649),
      outline: Color(4291611586),
      outlineVariant: Color(4291611586),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293255904),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4280888100),
      primaryFixed: Color(4293453789),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4291611585),
      onPrimaryFixedVariant: Color(4279637777),
      secondaryFixed: Color(4293519329),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291676869),
      onSecondaryFixedVariant: Color(4279637524),
      tertiaryFixed: Color(4293126375),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4291218635),
      onTertiaryFixedVariant: Color(4279375639),
      surfaceDim: Color(4279505683),
      surfaceBright: Color(4282005816),
      surfaceContainerLowest: Color(4279111181),
      surfaceContainerLow: Color(4280032027),
      surfaceContainer: Color(4280295199),
      surfaceContainerHigh: Color(4280953385),
      surfaceContainerHighest: Color(4281677108),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        // textTheme: textTheme.apply(
        //       bodyColor: colorScheme.onSurface,
        //       displayColor: colorScheme.onSurface,
        // ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
