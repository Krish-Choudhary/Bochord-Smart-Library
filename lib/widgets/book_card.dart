import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.bookName, required this.coverPage});

  final String coverPage;
  final String bookName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return const SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('This is the Modal Bottom Sheet.'),
                  ),
                ),
              );
            });
      },
      child: Stack(children: [
        Image.asset(
          coverPage,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
            height: 35,
            color: Colors.black54,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
            child: Text(
              bookName,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              softWrap: true,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }
}



// Stack(
//           children: [
//             Hero(
//               tag: meal.id,
//               child: FadeInImage(
//                 placeholder: MemoryImage(kTransparentImage),
//                 image: NetworkImage(meal.imageUrl),
//                 fit: BoxFit.cover,
//                 height: 200,
//                 width: double.infinity,
//               ),
//             ),
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 color: Colors.black54,
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 5,
//                   horizontal: 44,
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       meal.title,
//                       maxLines: 2,
//                       textAlign: TextAlign.center,
//                       softWrap: true,
//                       overflow: TextOverflow
//                           .ellipsis, // ends with ... in case of overflow
//                       style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         MealItemTrait(
//                           icon: Icons.schedule,
//                           label:
//                               "${meal.duration} min", //meal.duration is in integer so converting it to string
//                         ),
//                         const SizedBox(width: 12),
//                         MealItemTrait(icon: Icons.work, label: complexityText),
//                         const SizedBox(width: 12),
//                         MealItemTrait(
//                             icon: Icons.attach_money, label: affordabilityText),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),