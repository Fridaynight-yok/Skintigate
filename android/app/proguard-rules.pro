# Keep Firebase classes
-keep class com.google.firebase.** { *; }

# Keep ML Kit classes (if used)
-keep class com.google.mlkit.** { *; }

# Keep Flutter classes
-keep class io.flutter.** { *; }

# Keep anything with @Keep annotation
-keep @androidx.annotation.Keep class * { *; }

# Avoid stripping Application classes
-keep class com.example.skintigate.** { *; }
