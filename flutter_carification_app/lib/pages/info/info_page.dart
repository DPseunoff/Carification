import 'package:auto_route/auto_route.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/page_template.dart';
import 'package:flutter_carification_app/utils/app_assets.dart';
import 'package:flutter_carification_app/utils/app_textstyles.dart';
import 'package:flutter_carification_app/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBarTitle: 'Information',
      appBarAction: GestureDetector(
        onTap: () => context.router.pop(),
        child: SvgPicture.asset(AppAssets.exitIcon),
      ),
      body: Positioned.fill(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8.5 + topAppbarPadding),
              Expanded(
                child:
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: BlurryContainer(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          blur: 10,
                          color: Colors.black.withOpacity(0.3),
                          child: Text(
                            'Приложение способно корректно обрабатывать следующие марки автомобилей:\n'
                            '${classes.join(', ')}.\n\n'
                            'К сожалению без АвтоВАЗ и Škoda.\n\n'
                            'На главном экране есть карусель, в которой всегда показаны последние три загруженные фотографии с предсказанной маркой. '
                            'Если вам понравилось, как приложение угадало марку, вы можете добавить фотографию в галерею, поставив лайк.\n\n'
                            'Также на главном экране находится основная кнопка, которая дает выбор: загрузить фотографию из галереи телефона или сделать новую на камеру.\n\n'
                            'Карточки в галерее можно зажать и удалить, в таком случае фотография с предсказанием удаляется навсегда из галереи и карусели.\n\n'
                            'Приложение написано в качестве дипломной работы\n'
                            'Псеунов Д.Р. М8О-405Б-19\nМАИ, 2023',
                            style: AppTextStyles.onBoardingDescription(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
