import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

class TopRankedUser extends StatelessWidget {
  final double _radius;
  final Color _crownColor;
  final int _rank;
  final dynamic _user;
  final dynamic _myId;
  final bool _isFirstFilterSelected;
  final Function? _callBack;

  const TopRankedUser(this._radius, this._rank, this._user, this._myId, this._isFirstFilterSelected, [this._callBack, this._crownColor = Colors.lightBlue]) : super(key: null);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _rank != 1 ? 16 : 0),
      child: GestureDetector(
        onTap: _user.id != _myId ? _callBack?.call() : null,
        child: Column(
          children: <Widget>[
            if (_rank == 1)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SvgPicture.asset(
                  'assets/crown.svg',
                  colorFilter: ColorFilter.mode(_crownColor, BlendMode.srcIn),
                  width: 34,
                  height: 34,
                ).animate(
                  delay: 1000.ms,
                  onPlay: (AnimationController controller) => controller.repeat(),
                ).shimmer(
                  delay: 1000.ms,
                  duration: 2000.ms,
                  stops: <double>[0, 0.5, 1],
                ),
              ),
            Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: <Widget>[
                CircleAvatar(
                  radius: _rank == 1 ? 80 : 70,
                  backgroundColor: theme.colorScheme.primary,
                  child: CircleAvatar(
                    radius: _rank == 1 ? 75 : 65,
                    backgroundColor: theme.colorScheme.secondary,
                    backgroundImage: CachedNetworkImageProvider(
                      _user.photo,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  child: CircleAvatar(
                    radius: _radius,
                    backgroundColor: theme.colorScheme.primary,
                    child: Text(
                      _rank.toString(),
                      style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(_user.firstName.split(' ').first, style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700)),
            Text('${_isFirstFilterSelected ? _user.firstFilterPoints : _user.secondFilterPoints} pts', style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
