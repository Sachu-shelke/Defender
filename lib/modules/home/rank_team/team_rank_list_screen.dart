import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/modules/home/home_widget/user_rank_widget/home_tabel.dart';
import 'package:defenders/modules/home/rank_team/team_rank_list_model.dart';
import 'package:defenders/modules/home/rank_team/team_rank_list_presenter.dart';
import 'package:defenders/modules/home/rank_team/team_rank_list_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class TeamRankListScreen extends StatefulWidget {
  final String rank;
  final int rankCount;

  const TeamRankListScreen(
      {super.key, required this.rankCount, required this.rank});

  @override
  State<TeamRankListScreen> createState() => _TeamRankListScreenState();
}

class _TeamRankListScreenState extends State<TeamRankListScreen>
    implements TeamRankListView {
  late TeamRankListModel model;
  TeamRankListPresenter presenter = BasicTeamRankListPresenter();
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  _scrollListener() {
    if (_scrollController.position.maxScrollExtent ==
        (_scrollController.offset)) {
      setState(() {
        page++;
      });
      presenter.getRankTeam(
          context: context, page: page, rankName: widget.rank);
    }
  }

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    _scrollController.addListener(_scrollListener);
    presenter.getRankTeam(context: context, page: page, rankName: widget.rank);
  }

  @override
  void refreshModel(TeamRankListModel homeModel) {
    model = homeModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.rank),
      body: ListView.builder(
        itemCount: model.data.length,
        controller: _scrollController,
        padding: EdgeInsets.zero,
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            padding: const EdgeInsets.all(1),
            child: InnerShadow(
              blur: 5,
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(5, 5),
              child: SilverDetails(
                usermrid: model.data[index].mlmId.toString(),
                name: model.data[index].name.toString(),
                index: (widget.rankCount - index).toString(),
                address: model.data[index].address.toString(),
                date: DateFormat.yMd().format(
                    DateTime.parse(model.data[index].achiveDate.toString())),
                state: model.data[index].address.toString(),
              ),
              // Container(
              //   decoration: const BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(8)),
              //     color: Color(0xFFE9EFEC),
              //   ),
              //   height: 100,
              // ),
            ),
          );
          // ListTile(
          //   title: SilverDetails(
          //     usermrid: model.data[index].mlmId.toString(),
          //     name: model.data[index].name.toString(),
          //     index: (index + 1).toString(),
          //     state: model.data[index].address.toString(),
          //   ),
          // );
        }),
      ),
    );
  }
}
