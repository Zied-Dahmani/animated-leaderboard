import 'package:animated_leaderboard/src/leaderboard_card.dart';
import 'package:animated_leaderboard/src/silver_header_delegate.dart';
import 'package:animated_leaderboard/src/top_ranked_user.dart';
import 'package:flutter/material.dart';

class AnimatedLeaderboard extends StatelessWidget {
  final ScrollController _scrollController;
  final double _topContainer;
  final double _radius;
  final String _filterLabel1;
  final String _filterLabel2;
  final List<dynamic> _users;
  final dynamic _myId;
  final bool _isFirstFilterSelected;
  final ValueChanged<bool> _filterTapCallBack;

  const AnimatedLeaderboard(this._scrollController, this._topContainer, this._filterLabel1, this._filterLabel2, this._users, this._myId, this._isFirstFilterSelected, this._filterTapCallBack, [this._radius = 20]) : super(key: null);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: (1 - _topContainer * 2).clamp(0.0, 1.0),
            child: AnimatedContainer(
              padding: const EdgeInsets.symmetric(vertical: 16),
              duration: const Duration(milliseconds: 200),
              height: (1 - _topContainer * 2).clamp(0.0, 1.0) * (height / 3),
              width: width,
              child: FittedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TopRankedUser(
                      _radius,
                      2,
                      _users[1],
                      _myId,
                      _isFirstFilterSelected
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: TopRankedUser(
                          _radius,
                          1,
                          _users.first,
                          _myId,
                          _isFirstFilterSelected
                      ),
                    ),
                    TopRankedUser(
                        _radius,
                        3,
                        _users[2],
                        _myId,
                        _isFirstFilterSelected
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverHeaderDelegate(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_radius * 2),
                  topRight: Radius.circular(_radius * 2),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(10),
                width: width,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface,
                  borderRadius: BorderRadius.all(
                    Radius.circular(_radius),
                  ),
                ),
                child: Row(
                  children: List<Widget>.generate(
                    2,
                        (int index) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _filterTapCallBack(index == 0);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          decoration: BoxDecoration(
                            color: (index == 0 && _isFirstFilterSelected) || (index == 1 && !_isFirstFilterSelected)
                                ? theme.colorScheme.secondary
                                : theme.colorScheme.onSurface,
                            borderRadius: BorderRadius.all(
                              Radius.circular(_radius),
                            ),
                          ),
                          child: Text(
                            index == 0 ? _filterLabel1 : _filterLabel2,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700, color: (index == 0 && _isFirstFilterSelected) || (index == 1 && !_isFirstFilterSelected) ? theme.colorScheme.onSecondary : theme.colorScheme.onSurface),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: width,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  _topContainer > .6
                      ? _radius * 2
                      : 0,
                ),
                topRight: Radius.circular(
                  _topContainer > .6
                      ? _radius * 2
                      : 0,
                ),
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _topContainer > .3 ? _users.length : _users.length - 3,
              itemBuilder: (BuildContext context, int index) {
                return LeaderboardCard(
                  _radius,
                  _topContainer > .3 ? index + 1 : index + 4,
                  _users[_topContainer > .3 ? index : index + 3],
                  _myId,
                  _isFirstFilterSelected
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}