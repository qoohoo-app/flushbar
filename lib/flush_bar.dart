import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

part 'flush_bar_route.dart';
part 'flush_barx.dart';

typedef FlushBarStatusCallback = void Function(FlushBarStatus? status);
typedef OnTap = void Function(FlushBar flushBar);

/// A highly customizable widget so you can notify your user when you fell like he needs a beautiful explanation.
class FlushBar<T> extends StatefulWidget {
  FlushBar({
    Key? key,
    String? title,
    Color? titleColor,
    double? titleSize,
    String? message,
    double? messageSize,
    Color? messageColor,
    Widget? titleText,
    Widget? messageText,
    Widget? icon,
    bool shouldIconPulse = true,
    double? maxWidth,
    EdgeInsets margin = const EdgeInsets.all(0.0),
    EdgeInsets padding = const EdgeInsets.all(16),
    BorderRadius? borderRadius,
    Color? borderColor,
    double borderWidth = 1.0,
    Color backgroundColor = const Color(0xFF303030),
    Color? leftBarIndicatorColor,
    List<BoxShadow>? boxShadows,
    Gradient? backgroundGradient,
    Widget? actions,
    OnTap? onTap,
    Duration? duration,
    bool isDismissible = true,
    FlushBarActionsArrangement actionsArrangement = FlushBarActionsArrangement.vertical,
    FlushBarDismissDirection dismissDirection = FlushBarDismissDirection.vertical,
    bool showProgressIndicator = false,
    AnimationController? progressIndicatorController,
    Color? progressIndicatorBackgroundColor,
    Animation<Color>? progressIndicatorValueColor,
    FlushBarPosition flushBarPosition = FlushBarPosition.bottom,
    double positionOffset = 0.0,
    FlushBarStyle flushBarStyle = FlushBarStyle.floating,
    Curve forwardAnimationCurve = Curves.easeOutCirc,
    Curve reverseAnimationCurve = Curves.easeOutCirc,
    Duration animationDuration = const Duration(seconds: 1),
    FlushBarStatusCallback? onStatusChanged,
    double barBlur = 0.0,
    bool blockBackgroundInteraction = false,
    double? routeBlur,
    Color? routeColor,
    Form? userInputForm,
    Offset? endOffset,
  })  : title = title,
        titleSize = titleSize,
        titleColor = titleColor,
        message = message,
        messageSize = messageSize,
        messageColor = messageColor,
        titleText = titleText,
        messageText = messageText,
        icon = icon,
        shouldIconPulse = shouldIconPulse,
        maxWidth = maxWidth,
        margin = margin,
        padding = padding,
        borderRadius = borderRadius,
        borderColor = borderColor,
        borderWidth = borderWidth,
        backgroundColor = backgroundColor,
        leftBarIndicatorColor = leftBarIndicatorColor,
        boxShadows = boxShadows,
        backgroundGradient = backgroundGradient,
        actions = actions,
        onTap = onTap,
        duration = duration,
        isDismissible = isDismissible,
        actionsArrangement = actionsArrangement,
        dismissDirection = dismissDirection,
        showProgressIndicator = showProgressIndicator,
        progressIndicatorController = progressIndicatorController,
        progressIndicatorBackgroundColor = progressIndicatorBackgroundColor,
        progressIndicatorValueColor = progressIndicatorValueColor,
        flushBarPosition = flushBarPosition,
        positionOffset = positionOffset,
        flushBarStyle = flushBarStyle,
        forwardAnimationCurve = forwardAnimationCurve,
        reverseAnimationCurve = reverseAnimationCurve,
        animationDuration = animationDuration,
        barBlur = barBlur,
        blockBackgroundInteraction = blockBackgroundInteraction,
        routeBlur = routeBlur,
        routeColor = routeColor,
        userInputForm = userInputForm,
        onStatusChanged = onStatusChanged,
        endOffset = endOffset,
        super(key: key);

  /// A callback for you to listen to the different FlushBar status
  final FlushBarStatusCallback? onStatusChanged;

  /// The title displayed to the user
  final String? title;

  /// The title text size displayed to the user
  final double? titleSize;

  /// Color title displayed to the user ? default is black
  final Color? titleColor;

  /// The message displayed to the user.
  final String? message;

  /// The message text size displayed to the user.
  final double? messageSize;

  /// Color message displayed to the user ? default is black
  final Color? messageColor;

  /// Replaces [title]. Although this accepts a [Widget], it is meant to receive [Text] or [RichText]
  final Widget? titleText;

  /// Replaces [message]. Although this accepts a [Widget], it is meant to receive [Text] or  [RichText]
  final Widget? messageText;

  /// Will be ignored if [backgroundGradient] is not null
  final Color backgroundColor;

  /// If not null, shows a left vertical bar to better indicate the humor of the notification.
  /// It is not possible to use it with a [Form] and I do not recommend using it with [LinearProgressIndicator]
  final Color? leftBarIndicatorColor;

  /// [boxShadows] The shadows generated by FlushBar. Leave it null if you don't want a shadow.
  /// You can use more than one if you feel the need.
  /// Check (this example)[https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/shadows.dart]
  final List<BoxShadow>? boxShadows;

  /// Makes [backgroundColor] be ignored.
  final Gradient? backgroundGradient;

  /// You can use any widget here, but I recommend [Icon] or [Image] as indication of what kind
  /// of message you are displaying. Other widgets may break the layout
  final Widget? icon;

  /// An option to animate the icon (if present). Defaults to true.
  final bool shouldIconPulse;

  /// Use if you need an action from the user. [TextButton] is recommended here
  final Widget? actions;

  /// A callback that registers the user's click anywhere. An alternative to [actions]
  final OnTap? onTap;

  /// How long until FlushBar will hide itself (be dismissed). To make it indefinite, leave it null.
  final Duration? duration;

  /// True if you want to show a [LinearProgressIndicator].
  /// If [progressIndicatorController] is null, an infinite progress indicator will be shown
  final bool showProgressIndicator;

  /// An optional [AnimationController] when you want to control the progress of your [LinearProgressIndicator].
  /// You are responsible for controlling the progress
  final AnimationController? progressIndicatorController;

  /// A [LinearProgressIndicator] configuration parameter.
  final Color? progressIndicatorBackgroundColor;

  /// A [LinearProgressIndicator] configuration parameter.
  final Animation<Color>? progressIndicatorValueColor;

  /// Determines if the user can swipe or click the overlay (if [routeBlur] > 0) to dismiss.
  /// It is recommended that you set [duration] != null if this is false.
  /// If the user swipes to dismiss or clicks the overlay, no value will be returned.
  final bool isDismissible;

  /// Used to limit FlushBar width (usually on large screens)
  final double? maxWidth;

  /// Adds a custom margin to FlushBar
  final EdgeInsets margin;

  /// Adds a custom padding to FlushBar
  /// The default follows material design guide line
  final EdgeInsets padding;

  /// Adds a radius to corners specified of FlushBar. Best combined with [margin].
  /// I do not recommend using it with [showProgressIndicator] or [leftBarIndicatorColor].
  final BorderRadius? borderRadius;

  // Adds a border to every side of FlushBar
  /// I do not recommend using it with [showProgressIndicator] or [leftBarIndicatorColor].
  final Color? borderColor;

  /// Changes the width of the border if [borderColor] is specified
  final double borderWidth;

  /// FlushBar can be based on [FlushBarPosition.top] or on [FlushBarPosition.bottom] of your screen.
  /// [FlushBarPosition.bottom] is the default.
  final FlushBarPosition flushBarPosition;

  final double positionOffset;

  /// [FlushBarDismissDirection.vertical] by default.
  /// Can also be [FlushBarDismissDirection.horizontal] in which case both left and right dismiss are allowed.
  final FlushBarDismissDirection dismissDirection;

  /// FlushBar can be floating or be grounded to the edge of the screen.
  /// If grounded, I do not recommend using [margin] or [borderRadius]. [FlushBarStyle.floating] is the default
  /// If grounded, I do not recommend using a [backgroundColor] with transparency or [barBlur]
  final FlushBarStyle flushBarStyle;

  /// The [Curve] animation used when show() is called. [Curves.easeOut] is default
  final Curve forwardAnimationCurve;

  /// The [Curve] animation used when dismiss() is called. [Curves.fastOutSlowIn] is default
  final Curve reverseAnimationCurve;

  /// Use it to speed up or slow down the animation duration
  final Duration animationDuration;

  /// Default is 0.0. If different than 0.0, blurs only FlushBar's background.
  /// To take effect, make sure your [backgroundColor] has some opacity.
  /// The greater the value, the greater the blur.
  final double barBlur;

  /// Determines if user can interact with the screen behind it
  /// If this is false, [routeBlur] and [routeColor] will be ignored
  final bool blockBackgroundInteraction;

  /// Default is 0.0. If different than 0.0, creates a blurred
  /// overlay that prevents the user from interacting with the screen.
  /// The greater the value, the greater the blur.
  /// It does not take effect if [blockBackgroundInteraction] is false
  final double? routeBlur;

  /// Default is [Colors.transparent]. Only takes effect if [routeBlur] > 0.0.
  /// Make sure you use a color with transparency here e.g. Colors.grey[600].withOpacity(0.2).
  /// It does not take effect if [blockBackgroundInteraction] is false
  final Color? routeColor;

  /// A [TextFormField] in case you want a simple user input. Every other widget is ignored if this is not null.
  final Form? userInputForm;

  /// Offset to be added to the end FlushBar position.
  /// Intended to replace [margin] when you need items below FlushBar to be accessible
  final Offset? endOffset;

  /// Specifies whether main actions are arranged on the left or at the bottom
  final FlushBarActionsArrangement actionsArrangement;

  /// Will be used by FlushBar to push and pop itself
  late final FlushBarRoute<T?>? flushBarRoute;

  /// Show the flush bar. Kicks in [FlushBarStatus.isAppearing] state followed by [FlushBarStatus.showing]
  Future<T?> show(BuildContext context) async {
    flushBarRoute = showFlushBar<T>(
      context: context,
      flushBar: this,
    ) as FlushBarRoute<T?>;

    return await Navigator.of(context, rootNavigator: false).push(flushBarRoute as Route<T>);
  }

  /// Dismisses the flush bar causing is to return a future containing [result].
  /// When this future finishes, it is guaranteed that FlushBar was dismissed.
  Future<T?> dismiss([T? result]) async {
    final router = flushBarRoute;

    if (router != null) {
      if (router.isCurrent) {
        router.navigator?.pop(result);

        return router.completed;
      }

      if (router.isActive) {
        // removeRoute is called every time you dismiss a FlushBar that is not the top route.
        // It will not animate back and listeners will not detect FlushBarStatus.IS_HIDING or FlushBarStatus.DISMISSED
        // To avoid this, always make sure that FlushBar is the top route when it is being dismissed

        router.navigator?.removeRoute(router);
      }
    }

    return null;
  }

  /// Checks if the flush bar is visible
  bool get isShowing {
    final router = flushBarRoute;

    if (router != null) {
      return router.currentStatus == FlushBarStatus.showing;
    }

    return false;
  }

  /// Checks if the flush bar is dismissed
  bool get isDismissed {
    final router = flushBarRoute;

    if (router != null) {
      return router.currentStatus == FlushBarStatus.dismissed;
    }

    return false;
  }

  bool get isAppearing {
    final router = flushBarRoute;

    if (router != null) {
      return router.currentStatus == FlushBarStatus.isAppearing;
    }

    return false;
  }

  bool get isHiding {
    final router = flushBarRoute;

    if (router != null) {
      return router.currentStatus == FlushBarStatus.isHiding;
    }

    return false;
  }

  @override
  State createState() => _FlushBarState<T?>();
}

class _FlushBarState<K extends Object?> extends State<FlushBar<K>> with TickerProviderStateMixin {
  final Duration _pulseAnimationDuration = const Duration(seconds: 1);
  final Widget _emptyWidget = const SizedBox();
  final double _initialOpacity = 1.0;
  final double _finalOpacity = 0.4;

  GlobalKey? _backgroundBoxKey;
  FlushBarStatus? currentStatus;
  AnimationController? _fadeController;
  late Animation<double> _fadeAnimation;
  late bool _isTitlePresent;
  late double _messageTopMargin;
  FocusScopeNode? _focusNode;
  late FocusAttachment _focusAttachment;
  late Completer<Size> _boxHeightCompleter;

  CurvedAnimation? _progressAnimation;

  @override
  void initState() {
    super.initState();

    _backgroundBoxKey = GlobalKey();
    _boxHeightCompleter = Completer<Size>();

    assert(
        widget.userInputForm != null ||
            ((widget.message != null && widget.message!.isNotEmpty) || widget.messageText != null),
        'A message is mandatory if you are not using userInputForm. Set either a message or messageText');

    _isTitlePresent = (widget.title != null || widget.titleText != null);
    _messageTopMargin = _isTitlePresent ? 6.0 : widget.padding.top;

    _configureLeftBarFuture();
    _configureProgressIndicatorAnimation();

    if (widget.icon != null && widget.shouldIconPulse) {
      _configurePulseAnimation();
      _fadeController?.forward();
    }

    _focusNode = FocusScopeNode();
    _focusAttachment = _focusNode!.attach(context);
  }

  @override
  void dispose() {
    _fadeController?.dispose();
    widget.progressIndicatorController?.dispose();

    _focusAttachment.detach();
    _focusNode!.dispose();
    super.dispose();
  }

  void _configureLeftBarFuture() {
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) {
        final keyContext = _backgroundBoxKey!.currentContext;

        if (keyContext != null) {
          final box = keyContext.findRenderObject() as RenderBox;
          _boxHeightCompleter.complete(box.size);
        }
      },
    );
  }

  void _configureProgressIndicatorAnimation() {
    if (widget.showProgressIndicator && widget.progressIndicatorController != null) {
      _progressAnimation = CurvedAnimation(curve: Curves.linear, parent: widget.progressIndicatorController!);
    }
  }

  void _configurePulseAnimation() {
    _fadeController = AnimationController(vsync: this, duration: _pulseAnimationDuration);
    _fadeAnimation = Tween(begin: _initialOpacity, end: _finalOpacity).animate(
      CurvedAnimation(
        parent: _fadeController!,
        curve: Curves.linear,
      ),
    );

    _fadeController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeController!.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _fadeController!.forward();
      }
    });

    _fadeController!.forward();
  }

  //TODO : review EdgeInsets
  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 1.0,
      child: Material(
        color: widget.flushBarStyle == FlushBarStyle.floating ? Colors.transparent : widget.backgroundColor,
        child: SafeArea(
          minimum: widget.flushBarPosition == FlushBarPosition.bottom
              ? EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + widget.positionOffset)
              : EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top + widget.positionOffset),
          bottom: widget.flushBarPosition == FlushBarPosition.bottom,
          top: widget.flushBarPosition == FlushBarPosition.top,
          left: false,
          right: false,
          child: _getFlushBar(),
        ),
      ),
    );
  }

  Widget _getFlushBar() {
    Widget flushBar;

    if (widget.userInputForm != null) {
      flushBar = _generateInputFlushBar();
    } else {
      flushBar = _generateFlushBar();
    }

    return Stack(
      children: [
        FutureBuilder(
          future: _boxHeightCompleter.future,
          builder: (context, AsyncSnapshot<Size> snapshot) {
            if (snapshot.hasData) {
              if (widget.barBlur == 0) {
                //fixes https://github.com/cmdrootaccess/another-flush bar/issues/8
                return _emptyWidget;
              }
              return ClipRRect(
                borderRadius: widget.borderRadius,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: widget.barBlur, sigmaY: widget.barBlur),
                  child: Container(
                    height: snapshot.data!.height,
                    width: snapshot.data!.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: widget.borderRadius,
                    ),
                  ),
                ),
              );
            }
            return _emptyWidget;
          },
        ),
        flushBar,
      ],
    );
  }

  Widget _generateInputFlushBar() {
    return Container(
      key: _backgroundBoxKey,
      constraints: widget.maxWidth != null ? BoxConstraints(maxWidth: widget.maxWidth!) : null,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        boxShadow: widget.boxShadows,
        borderRadius: widget.borderRadius,
        border: widget.borderColor != null ? Border.all(color: widget.borderColor!, width: widget.borderWidth) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 16.0),
        child: FocusScope(
          node: _focusNode,
          autofocus: true,
          child: widget.userInputForm!,
        ),
      ),
    );
  }

  Widget _generateFlushBar() {
    return Container(
      key: _backgroundBoxKey,
      constraints: widget.maxWidth != null ? BoxConstraints(maxWidth: widget.maxWidth!) : null,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        boxShadow: widget.boxShadows,
        borderRadius: widget.borderRadius,
        border: widget.borderColor != null ? Border.all(color: widget.borderColor!, width: widget.borderWidth) : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProgressIndicator(),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: _getAppropriateRowLayout(),
          ),
          if (widget.actions != null && widget.actionsArrangement == FlushBarActionsArrangement.vertical)
            Padding(
              padding: EdgeInsets.only(
                left: widget.padding.left,
                right: widget.padding.right,
                bottom: widget.padding.bottom,
              ),
              child: _getActions() ?? _emptyWidget,
            ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    if (widget.showProgressIndicator && _progressAnimation != null) {
      return AnimatedBuilder(
          animation: _progressAnimation!,
          builder: (_, __) {
            return LinearProgressIndicator(
              value: _progressAnimation!.value,
              backgroundColor: widget.progressIndicatorBackgroundColor,
              valueColor: widget.progressIndicatorValueColor,
            );
          });
    }

    if (widget.showProgressIndicator) {
      return LinearProgressIndicator(
        backgroundColor: widget.progressIndicatorBackgroundColor,
        valueColor: widget.progressIndicatorValueColor,
      );
    }

    return _emptyWidget;
  }

  List<Widget> _getAppropriateRowLayout() {
    final iconPadding = widget.padding.left > 16.0 ? widget.padding.left : 0.0;

    if (widget.icon == null && widget.actions == null) {
      return [
        _buildLeftBarIndicator(),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.padding.top,
                        left: widget.padding.left,
                        right: widget.padding.right,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: widget.padding.left,
                  right: widget.padding.right,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
      ];
    }

    if (widget.icon != null && widget.actions == null) {
      return <Widget>[
        _buildLeftBarIndicator(),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 42.0 + iconPadding),
          child: _getIcon(),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.padding.top,
                        left: 4.0,
                        right: widget.padding.left,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: 4.0,
                  right: widget.padding.right,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
      ];
    }

    if (widget.icon == null && widget.actions != null) {
      return <Widget>[
        _buildLeftBarIndicator(),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.padding.top,
                        left: widget.padding.left,
                        right: widget.padding.right,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: widget.padding.left,
                  right: 8.0,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
        if (widget.actionsArrangement == FlushBarActionsArrangement.horizontal)
          Padding(
            padding: EdgeInsets.only(right: widget.padding.right),
            child: _getActions(),
          ),
      ];
    }

    return <Widget>[
      _buildLeftBarIndicator(),
      ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: 42.0 + iconPadding),
        child: _getIcon(),
      ),
      Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            (_isTitlePresent)
                ? Padding(
                    padding: EdgeInsets.only(
                      top: widget.padding.top,
                      left: 4.0,
                      right: 8.0,
                    ),
                    child: _getTitleText(),
                  )
                : _emptyWidget,
            Padding(
              padding: EdgeInsets.only(
                top: _messageTopMargin,
                left: 4.0,
                right: 8.0,
                bottom: widget.padding.bottom,
              ),
              child: widget.messageText ?? _getDefaultNotificationText(),
            ),
          ],
        ),
      ),
      _getActions() != null && widget.actionsArrangement == FlushBarActionsArrangement.horizontal
          ? Padding(
              padding: EdgeInsets.only(right: widget.padding.right),
              child: _getActions(),
            )
          : _emptyWidget,
    ];
  }

  Widget _buildLeftBarIndicator() {
    if (widget.leftBarIndicatorColor != null) {
      return FutureBuilder(
        future: _boxHeightCompleter.future,
        builder: (BuildContext buildContext, AsyncSnapshot<Size> snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: 8.0,
              height: snapshot.data!.height,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius == null
                    ? null
                    : BorderRadius.only(
                        topLeft: widget.borderRadius!.topLeft,
                        bottomLeft: widget.borderRadius!.bottomLeft,
                      ),
                color: widget.leftBarIndicatorColor,
              ),
            );
          } else {
            return _emptyWidget;
          }
        },
      );
    } else {
      return _emptyWidget;
    }
  }

  Widget? _getIcon() {
    if (widget.icon != null && widget.icon is Icon && widget.shouldIconPulse) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: widget.icon,
      );
    } else if (widget.icon != null) {
      return widget.icon;
    } else {
      return _emptyWidget;
    }
  }

  Widget? _getTitleText() {
    return widget.titleText ??
        Text(
          widget.title ?? '',
          style: TextStyle(
              fontSize: widget.titleSize ?? 16.0,
              color: widget.titleColor ?? Colors.white,
              fontWeight: FontWeight.bold),
        );
  }

  Text _getDefaultNotificationText() {
    return Text(
      widget.message ?? '',
      style: TextStyle(fontSize: widget.messageSize ?? 14.0, color: widget.messageColor ?? Colors.white),
    );
  }

  Widget? _getActions() {
    if (widget.actions != null) {
      return widget.actions;
    } else {
      return null;
    }
  }
}

/// Indicates if flush bar is going to start at the [top] or at the [bottom]
enum FlushBarPosition { top, bottom }

/// Indicates if flush bar will be attached to the edge of the screen or not
enum FlushBarStyle { floating, grounded }

/// Indicates the direction in which it is possible to dismiss
/// If vertical, dismiss up will be allowed if [FlushBarPosition.top]
/// If vertical, dismiss down will be allowed if [FlushBarPosition.bottom]
enum FlushBarDismissDirection { horizontal, vertical }

/// Indicates the placement of buttons (either below [FlushBarActionsArrangement.vertical] or
/// [FlushBarActionsArrangement.horizontal] the right)
enum FlushBarActionsArrangement { horizontal, vertical }

/// Indicates the animation status
/// [FlushBarStatus.showing] Flush bar has stopped and the user can see it
/// [FlushBarStatus.dismissed] Flush bar has finished its mission and returned any pending values
/// [FlushBarStatus.isAppearing] Flush bar is moving towards [FlushBarStatus.showing]
/// [FlushBarStatus.isHiding] Flush bar is moving towards [] [FlushBarStatus.dismissed]
enum FlushBarStatus { showing, dismissed, isAppearing, isHiding }
