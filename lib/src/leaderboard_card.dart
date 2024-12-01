import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LeaderboardCard extends StatelessWidget {
  final double _radius;
  final int _rank;
  final dynamic _user;
  final dynamic _myId;
  final bool _isFirstFilterSelected;
  final Function? _callBack;

  const LeaderboardCard(this._radius, this._rank, this._user, this._myId,
      this._isFirstFilterSelected,
      [this._callBack])
      : super(key: null);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: _user.id != _myId ? _callBack?.call() : null,
      child: Card(
        color: _user.id == _myId
            ? theme.colorScheme.primary.withOpacity(.2)
            : theme.colorScheme.onSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
        ),
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 100,
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Text(
                _rank.toString(),
                style: theme.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CircleAvatar(
                  radius: _radius * 2,
                  backgroundColor: theme.colorScheme.secondary,
                  backgroundImage: CachedNetworkImageProvider(
                    _user.photo,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${_user.firstName} ${_user.lastName}',
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${_isFirstFilterSelected ? _user.firstFilterPoints : _user.secondFilterPoints} pts',
                style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight:
                        _user.id == _myId ? FontWeight.w700 : FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
