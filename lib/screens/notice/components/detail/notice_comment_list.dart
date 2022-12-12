import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/content/default_avatar_content.dart';
import 'package:pyc/components/seperator/default_divider.dart';
import 'package:pyc/components/slidable/default_slidable_action.dart';
import 'package:pyc/data/model/notice_comment/response/notice_comment_response.dart';

class NoticeCommentList extends StatelessWidget {
  final int userId;
  final List<NoticeCommentResponse> comments;
  final int count;
  // final void Function(BuildContext)? Function(int, String) modifiy;
  final void Function(BuildContext)? Function(int, String) modifiy;
  final void Function(BuildContext)? Function(int) delete;

  const NoticeCommentList({
    super.key,
    required this.userId,
    required this.comments,
    required this.count,
    required this.modifiy,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < comments.length; i++)
            Slidable(
              enabled: userId == comments[i].createdBy,
              key: UniqueKey(),

              /// ActionPane
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  DefaultSlidableAction(
                    // onPressed: modifiy(comments[i].id, comments[i].comment),
                    onPressed: (
                      ctx,
                    ) =>
                        modifiy,
                    label: 'Modifiy',
                    icon: Icons.edit_note_outlined,
                    color: kPrimaryColor,
                  ),
                  DefaultSlidableAction(
                    onPressed: delete(comments[i].id),
                    label: 'Delete',
                    icon: Icons.delete,
                    color: Colors.red.shade600,
                  ),
                ],
              ),

              /// Comment List Item
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: kDefaultValue / 2,
                      horizontal: kDefaultValue,
                    ),
                    child: DefaultAvatarContent(
                      title: comments[i].creator.name,
                      content: comments[i].comment,
                      subContent: '\n\n${DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(comments[i].createdAt).toString()}',
                      avatarImage: comments[i].creator.image,
                    ),
                  ),
                  if (i < comments.length - 1) getDefaultDivider(width: kDefaultValue * 0.1),
                ],
              ),
            ),
          const SizedBox(height: kDefaultValue * 2),
        ],
      ),
    );
  }
}
