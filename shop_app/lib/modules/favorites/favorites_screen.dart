import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).getFavoritesModel != null,
            builder: (context) =>
                (ShopCubit.get(context).getFavoritesModel!.data!.data.isEmpty)
                    ? const Center(
                        child: Text('No Favorites, add more'),
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildFavItem(
                              context,
                              ShopCubit.get(context)
                                  .getFavoritesModel!
                                  .data!
                                  .data[index],
                            ),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: ShopCubit.get(context)
                            .getFavoritesModel!
                            .data!
                            .data
                            .length),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildFavItem(context, FavProductData model) => Container(
        padding: const EdgeInsets.all(20),
        height: 125,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.product!.image!),
                  width: 125,
                  height: 125,
                ),
                if (model.product!.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  )
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product!.price}',
                        style: TextStyle(fontSize: 12, color: defaultColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.product!.discount != 0)
                        Text(
                          '${model.product!.oldPrice}',
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: CircleAvatar(
                          backgroundColor: ShopCubit.get(context)
                                  .inFavorites[model.product!.id]!
                              ? defaultColor
                              : Colors.grey,
                          radius: 15,
                          child: const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        onPressed: () {
                          // do same thing here also
                          ShopCubit.get(context)
                              .changeFavorites(model.product!.id!);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
