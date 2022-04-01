import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class TaskCard extends StatelessWidget {
  int id;
  String title;
  String description;
  bool isComplete;
  String createdAt;
  Function onChanged;
  Function onTap;
  TaskCard({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
    required this.createdAt,
    required this.onChanged,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GrockContainer(
      onTap: () => onTap(),
      padding: 10.allP,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
        borderRadius: 10.allBR,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${id}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              GrockContainer(
                onTap: () => onChanged(),
                padding: 5.allP,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: 5.allBR,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      ),
                    ]),
                child: Icon(
                  isComplete
                      ? CupertinoIcons.clear_thick
                      : CupertinoIcons.check_mark,
                  size: 16,
                  color:
                      isComplete ? Colors.red.shade900 : Colors.green.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              createdAt.substring(0, 10),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }
}
