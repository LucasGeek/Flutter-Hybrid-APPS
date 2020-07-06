import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hg_brasil/app/app_controller.dart';
import 'package:hg_brasil/app/shared/util/color.dart';
import 'package:hg_brasil/app/shared/util/loading.dart';
import 'package:hg_brasil/app/shared/util/screen.dart';

class DefaultButton extends StatefulWidget {
  final String text;
  final Function function;

  final Color color;
  final Color colorBorder;
  final Color colorText;
  final double radius;
  final Widget icon;
  final Widget loading;
  final double width;
  final double height;
  final ProgressButtonType type;

  DefaultButton({
    @required this.text,
    @required this.function,
    this.radius,
    this.icon,
    this.width,
    this.height,
    this.type,
    this.color,
    this.colorBorder,
    this.colorText,
    this.loading,
  });

  @override
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  ProgressButtonType typeButton;
  Widget defaultWidget;
  Widget animationWidget;
  Color colorButton;
  Color colorText;
  Color colorButtonBorder;
  double borderRadius;
  double height;
  double width;

  Screen screen;
  AppController appController;

  @override
  void initState() {
    screen = Modular.get<Screen>();
    appController = Modular.get<AppController>();

    if (widget.color != null) {
      colorButton = widget.color;
    } else {
      colorButton = AppColors.primary;
    }

    if (widget.colorText != null) {
      colorText = widget.colorText;
    } else {
      if (appController.isMaterial) {
        colorText = AppColors.whiteColor;
      } else {
        colorText = AppColors.primary;
      }
    }

    if (widget.colorBorder != null) {
      colorButtonBorder = widget.colorBorder;
    } else {
      colorButtonBorder = AppColors.primary;
    }

    if (widget.height != null) {
      height = widget.height;
    } else {
      height = screen.screenHeightDp / 12;
    }

    if (widget.width != null) {
      width = widget.width;
    } else {
      width = screen.screenWidthDp;
    }

    if (widget.radius != null) {
      borderRadius = widget.radius;
    } else {
      if (appController.isCupertino) {
        borderRadius = 15.0;
      } else {
        borderRadius = 50.0;
      }
    }

    if (widget.type != null) {
      typeButton = widget.type;
    } else {
      if (appController.isMaterial) {
        typeButton = ProgressButtonType.Raised;
      } else if (appController.isCupertino) {
        typeButton = ProgressButtonType.Outline;
      } else {
        typeButton = ProgressButtonType.Flat;
      }
    }

    if (widget.loading != null) {
      animationWidget = widget.loading;
    } else {
      if (appController.isMaterial) {
        animationWidget = BallPulseSyncIndicator(
          color_1: Colors.white,
          color_2: Colors.white,
          color_3: Colors.white,
        );
      } else {
        animationWidget = BallPulseSyncIndicator(
          color_1: AppColors.primary,
          color_2: AppColors.primary,
          color_3: AppColors.primary,
        );
      }
    }

    if (widget.icon != null) {
      defaultWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 5),
            child: widget.icon,
          ),
          Container(
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.colorText,
                fontSize: screen.setSp(38),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
    } else {
      defaultWidget = Text(
        widget.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colorText,
          fontSize: screen.setSp(38),
          fontWeight: FontWeight.bold,
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ProgressButton(
          defaultWidget: defaultWidget,
          onPressed: widget.function,
          color: colorButton,
          colorBorder: colorButtonBorder,
          height: height,
          width: width,
          borderRadius: borderRadius,
          animate: appController.isMaterial,
          type: typeButton,
          progressWidget: animationWidget,
          progressButtonState: ProgressButtonState.Default,
        );
      },
    );
  }
}

class ProgressButton extends StatefulWidget {
  final Widget defaultWidget;
  final Widget progressWidget;
  final Function onPressed;
  final ProgressButtonType type;
  final Color color;
  final Color colorBorder;
  final double width;
  final double height;
  final double borderRadius;
  final bool animate;
  final ProgressButtonState progressButtonState;

  ProgressButton({
    Key key,
    this.defaultWidget,
    this.progressWidget,
    this.onPressed,
    this.type = ProgressButtonType.Raised,
    this.color,
    this.colorBorder,
    this.width = double.infinity,
    this.height = 40.0,
    this.borderRadius = 2.0,
    this.animate = true,
    this.progressButtonState = ProgressButtonState.Default,
  }) : super(key: key);

  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton> with TickerProviderStateMixin {
  GlobalKey _globalKey = GlobalKey();
  Animation _anim;
  AnimationController _animController;
  Duration _duration = const Duration(milliseconds: 250);
  ProgressButtonState _state;
  double _width;
  double _height;
  double _borderRadius;

  @override
  dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _reset();
    super.deactivate();
  }

  @override
  void initState() {
    _reset();
    super.initState();
  }

  void _reset() {
    _state = widget.progressButtonState;
    _width = widget.width;
    _height = widget.height;
    _borderRadius = widget.borderRadius;
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: SizedBox(
        key: _globalKey,
        height: _height,
        width: _width,
        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    var padding = const EdgeInsets.all(0.0);
    var color = widget.color;

    var shape = RoundedRectangleBorder(
      side: BorderSide(color: widget.colorBorder, width: 4, style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(_borderRadius),
    );

    switch (widget.type) {
      case ProgressButtonType.Raised:
        return RaisedButton(
          padding: padding,
          color: color,
          shape: shape,
          child: _buildChildren(context),
          onPressed: _onButtonPressed(),
        );
      case ProgressButtonType.Flat:
        return FlatButton(
          padding: padding,
          color: color,
          shape: shape,
          child: _buildChildren(context),
          onPressed: _onButtonPressed(),
        );
      case ProgressButtonType.Outline:
        return OutlineButton(
          padding: padding,
          color: color,
          shape: shape,
          borderSide: BorderSide(color: widget.colorBorder),
          highlightedBorderColor: widget.colorBorder,
          child: _buildChildren(context),
          onPressed: _onButtonPressed(),
        );
    }
  }

  Widget _buildChildren(BuildContext context) {
    Widget ret;
    switch (_state) {
      case ProgressButtonState.Default:
        ret = widget.defaultWidget;
        break;
      case ProgressButtonState.Processing:
        ret = widget.progressWidget ?? widget.defaultWidget;
        break;
    }
    return ret;
  }

  VoidCallback _onButtonPressed() {
    return widget.onPressed == null
        ? null
        : () async {
            if (_state != ProgressButtonState.Default) {
              return;
            }

            // The result of widget.onPressed() will be called as VoidCallback after button status is back to default.
            VoidCallback onDefault;
            if (widget.animate) {
              _toProcessing();
              _forward((status) {
                if (status == AnimationStatus.dismissed) {
                  _toDefault();
                  if (onDefault != null && onDefault is VoidCallback) {
                    onDefault();
                  }
                }
              });
              onDefault = await widget.onPressed();
              _reverse();
            } else {
              _toProcessing();
              onDefault = await widget.onPressed();
              _toDefault();
              if (onDefault != null && onDefault is VoidCallback) {
                onDefault();
              }
            }
          };
  }

  void _toProcessing() {
    setState(() {
      _state = ProgressButtonState.Processing;
    });
  }

  void _toDefault() {
    if (mounted) {
      setState(() {
        _state = ProgressButtonState.Default;
      });
    } else {
      _state = ProgressButtonState.Default;
    }
  }

  void _forward(AnimationStatusListener stateListener) {
    double initialWidth = _globalKey.currentContext.size.width;
    double initialBorderRadius = widget.borderRadius;
    double targetWidth = _height;
    double targetBorderRadius = _height / 2;

    _animController = AnimationController(duration: _duration, vsync: this);
    _anim = Tween(begin: 0.0, end: 1.0).animate(_animController)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - targetWidth) * _anim.value);
          _borderRadius = initialBorderRadius - ((initialBorderRadius - targetBorderRadius) * _anim.value);
        });
      })
      ..addStatusListener(stateListener);

    _animController.forward();
  }

  void _reverse() {
    _animController.reverse();
  }
}

enum ProgressButtonState {
  Default,
  Processing,
}

enum ProgressButtonType {
  Raised,
  Flat,
  Outline,
}
