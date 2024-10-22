class LayoutConfig {
  final double headerHeight;
  final double sidebarWidth;
  final double sidebarHeight;
  final double contentPadding;
  final double borderRadius;

  LayoutConfig({
    this.headerHeight = 50,
    this.sidebarWidth = 60,
    this.sidebarHeight = 60,
    this.contentPadding = 10,
    this.borderRadius = 15,
  });

  double get contentLeftPadding => sidebarWidth + contentPadding;
  double get contentTopPadding => headerHeight + contentPadding;
  double get contentBottomPadding => sidebarHeight + contentPadding;
}
