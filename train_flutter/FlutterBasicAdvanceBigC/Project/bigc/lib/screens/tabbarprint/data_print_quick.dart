import 'package:bigc/components/checkbox_custom.dart';
import 'package:bigc/components/textfield_custom.dart';
import 'package:bigc/themes/colors.dart';
import 'package:bigc/utils/constants.dart';
import 'package:flutter/material.dart';

Widget dataPrintQuick({ required bool ckSF, required Function(bool?) onChangedSF, required bool ckBS, required Function(bool?) onChangedBS }) {
  return Column(
    children: [
      Row(
        children: const [
          Expanded(
              flex: 2,
              child: Text("Bar:", style: TextStyle(fontSize: TEXT_SIZE_Small))),
          Expanded(
            flex: 10,
            child: TextFieldCustom(
              readOnly: false,
              initialValue: '8851123212021',
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 5,
              bgColor: whiteColor,
              borderColor: grayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_Small,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            flex: 10,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: '100572653 SO',
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 5,
              bgColor: inputBgColor,
              borderColor: grayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_Small,
            ),
          ),
        ],
      ),

      Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2),
        child: Row(
          children: const [
            Expanded(flex: 2,child: Text("")),
            Expanded(
              flex: 20,
              child: TextFieldCustom(
                readOnly: true,
                initialValue: 'BP เครื่องดื่มM-150.150CC..P.10',
                textInputType: TextInputType.text,
                obscureText: false,
                autofocus: false,
                size: 5,
                bgColor: inputBgColor,
                borderColor: grayColor,
                borderWidth: 1,
                borderRadius: 5,
                fontSize: TEXT_SIZE_Small,
              ),
            ),
          ],
        ),
      ),

      Row(
        children: const [
          Expanded(
              flex: 2,
              child: Text("MD:", style: TextStyle(fontSize: TEXT_SIZE_Small))),
          Expanded(
            flex: 12,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: 'BP.PACK10d',
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 5,
              bgColor: inputBgColor,
              borderColor: grayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_Small,
            ),
          ),
          Expanded(
            flex: 8,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: 'PB',
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 5,
              bgColor: inputBgColor,
              borderColor: grayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_Small,
            ),
          ),
        ],
      ),

      Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2),
        child: Row(
          children: const [
            Expanded(
                flex: 2,
                child: Text("ST:", style: TextStyle(fontSize: TEXT_SIZE_Small))),
            Expanded(
              flex: 6,
              child: TextFieldCustom(
                readOnly: true,
                initialValue: 'A',
                textInputType: TextInputType.text,
                obscureText: false,
                autofocus: false,
                size: 5,
                bgColor: inputBgColor,
                borderColor: grayColor,
                borderWidth: 1,
                borderRadius: 5,
                fontSize: TEXT_SIZE_Small,
              ),
            ),
            Expanded(
              flex: 8,
              child: TextFieldCustom(
                readOnly: true,
                initialValue: 'POG210716',
                textInputType: TextInputType.text,
                obscureText: false,
                autofocus: false,
                size: 5,
                bgColor: inputBgColor,
                borderColor: grayColor,
                borderWidth: 1,
                borderRadius: 5,
                fontSize: TEXT_SIZE_Small,
              ),
            ),
            Expanded(
              flex: 6,
              child: TextFieldCustom(
                readOnly: true,
                textInputType: TextInputType.text,
                obscureText: false,
                autofocus: false,
                size: 5,
                bgColor: inputBgColor,
                borderColor: grayColor,
                borderWidth: 1,
                borderRadius: 5,
                fontSize: TEXT_SIZE_Small,
              ),
            ),
          ],
        ),
      ),

      Row(
        children: const [
          Expanded(
              flex: 2,
              child: Text("SP:", style: TextStyle(fontSize: TEXT_SIZE_Small))),
          Expanded(
            flex: 9,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: '86',
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 5,
              bgColor: inputBgColor,
              borderColor: grayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_Small,
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 2),
                child: Text("NP:", style: TextStyle(fontSize: TEXT_SIZE_Small)),
              )),
          Expanded(
            flex: 9,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: '86',
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 5,
              bgColor: inputBgColor,
              borderColor: grayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_Small,
            ),
          ),
        ],
      ),

      Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2),
        child: Row(
          children: const [
            Expanded(
                flex: 2,
                child: Text("BOH:", style: TextStyle(fontSize: TEXT_SIZE_XSmall))),
            Expanded(
              flex: 9,
              child: TextFieldCustom(
                readOnly: true,
                initialValue: '-2785',
                textInputType: TextInputType.text,
                obscureText: false,
                autofocus: false,
                size: 5,
                bgColor: btnLogoutColor,
                borderColor: grayColor,
                borderWidth: 1,
                borderRadius: 5,
                fontSize: TEXT_SIZE_Small,
                fontColor: whiteColor,
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 2),
                  child: Text("BOD:", style: TextStyle(fontSize: TEXT_SIZE_XSmall)),
                )),
            Expanded(
              flex: 9,
              child: TextFieldCustom(
                readOnly: true,
                initialValue: '470',
                textInputType: TextInputType.text,
                obscureText: false,
                autofocus: false,
                size: 5,
                bgColor: inputBgColor,
                borderColor: grayColor,
                borderWidth: 1,
                borderRadius: 5,
                fontSize: TEXT_SIZE_Small,
              ),
            ),
          ],
        ),
      ),

      Row(
        children: [
          const Expanded(
              flex: 2,
              child: Text("PZ:", style: TextStyle(fontSize: TEXT_SIZE_Small))),
          const Expanded(
            flex: 9,
            child: TextFieldCustom(
              readOnly: true,
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 5,
              bgColor: inputBgColor,
              borderColor: grayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_Small,
            ),
          ),
          const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 2),
                child: Text("P1:", style: TextStyle(fontSize: TEXT_SIZE_Small)),
              )),
          const Expanded(
            flex: 5,
            child: TextFieldCustom(
              readOnly: false,
              initialValue: '1',
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 5,
              bgColor: whiteColor,
              borderColor: grayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_Small,
            ),
          ),
          Expanded(
            flex: 4,
            child: CheckboxCustom(
              name: 'SF',
              fontSize: TEXT_SIZE_Small,
              borderRadius: 5,
              val: ckSF,
              onChanged: onChangedSF,
            )
          )
        ],
      ),

      Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2),
        child: Row(
          children: [
            const Expanded(
                flex: 4,
                child: Text("บาร์ล่าสุด:", style: TextStyle(fontSize: TEXT_SIZE_XSmall))),
            const Expanded(
              flex: 14,
              child: TextFieldCustom(
                readOnly: true,
                initialValue: '8851123212021',
                textInputType: TextInputType.text,
                obscureText: false,
                autofocus: false,
                size: 5,
                bgColor: inputBgColor,
                borderColor: grayColor,
                borderWidth: 1,
                borderRadius: 5,
                fontSize: TEXT_SIZE_Small,
              ),
            ),
            Expanded(
              flex: 4,
              child: CheckboxCustom(
                name: 'B/S',
                fontSize: TEXT_SIZE_Small,
                borderRadius: 5,
                val: ckBS,
                onChanged: onChangedBS,
              )
            )
          ],
        ),
      )

    ],
  );
}
