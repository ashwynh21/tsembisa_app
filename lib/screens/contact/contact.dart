import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timeago/timeago.dart';
import 'package:tsembisa/blocs/contacts/contacts_bloc.dart';
import 'package:tsembisa/blocs/traces/traces_bloc.dart';
import 'package:tsembisa/components/error.dart';
import 'package:tsembisa/screens/checkin/elements/background.dart';
import 'package:tsembisa/theme/colors.dart';

class Contact extends StatefulWidget {
  createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final TextEditingController name = new TextEditingController(),
      number = new TextEditingController();
  final FocusNode second = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
          color: Colors.white,

          child: MultiBlocProvider(
            providers: [
              BlocProvider<ContactsBloc>(create: (_) => new ContactsBloc()),
              BlocProvider<TracesBloc>(create: (_) => (new TracesBloc())..add(ReadTraces()))
            ],
            child: Stack(
              children: [
                Background(),

                SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 256, left: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Contact traces',
                                style: TextStyle(
                                    fontSize: 32,
                                    color: primary,
                                    fontWeight: FontWeight.w600
                                ),
                              )
                          ),

                          /*
                            * Then here we should have the form for the trace input
                            * */
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              child: Row(
                                children: [
                                  Material(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(24),
                                      child: Container(
                                          width: 64,
                                          height: 64,
                                          color: Colors.transparent,

                                          child: Stack(
                                            children: [

                                              Center(
                                                  child: SvgPicture.asset('lib/assets/icons/avatar.svg', width: 28, color: accent)
                                              ),
                                              InkWell(
                                                borderRadius: BorderRadius.circular(24),
                                                highlightColor: accent.withOpacity(0.24),
                                                splashColor: accent.withOpacity(0.16),

                                                onTap: () {
                                                },
                                              )
                                            ],
                                          )
                                      )
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width - 160,
                                    margin: EdgeInsets.only(left: 16),
                                    child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 12),
                                          child: TextField(
                                            controller: name,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Full name',
                                              hintStyle: TextStyle(
                                                fontSize: 18,
                                                color: accent.withOpacity(.48),
                                                height: .0,
                                              ),
                                              contentPadding: EdgeInsets.all(.0),
                                            ),
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.next,

                                            onSubmitted: (value) {
                                              FocusScope.of(context).requestFocus(second);
                                            },
                                          ),
                                        )
                                    ),
                                  )
                                ],
                              )
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              child: Row(
                                children: [
                                  Material(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(24),
                                      child: Container(
                                          width: 64,
                                          height: 64,
                                          color: Colors.transparent,

                                          child: Stack(
                                            children: [

                                              Center(
                                                  child: SvgPicture.asset('lib/assets/icons/phone.svg', width: 28, color: accent)
                                              ),
                                              InkWell(
                                                borderRadius: BorderRadius.circular(24),
                                                highlightColor: accent.withOpacity(0.24),
                                                splashColor: accent.withOpacity(0.16),

                                                onTap: () {
                                                },
                                              )
                                            ],
                                          )
                                      )
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width - 160,
                                    margin: EdgeInsets.only(left: 16),
                                    child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 12),
                                          child: TextField(
                                            controller: number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Mobile number',
                                              hintStyle: TextStyle(
                                                fontSize: 18,
                                                color: accent.withOpacity(.48),
                                                height: .0,
                                              ),
                                              contentPadding: EdgeInsets.all(.0),
                                            ),
                                            keyboardType: TextInputType.phone,
                                            textInputAction: TextInputAction.done,
                                            focusNode: second,
                                          ),
                                        )
                                    ),
                                  )
                                ],
                              )
                          ),
                          /*
                        * Here we should consider adding the tracing history*/
                          Container(
                            height: 0.5,
                            width: MediaQuery.of(context).size.width - 64,
                            color: Colors.black.withOpacity(0.16),
                            margin: EdgeInsets.symmetric(vertical: 24),
                          ),

                          BlocListener<ContactsBloc, ContactsState>(
                            listener: (contactscontext, state) {
                              if(state is ContactCreatedState) {
                                BlocProvider.of<TracesBloc>(contactscontext).add(ReadTraces());
                              }
                            },
                            child: BlocBuilder<TracesBloc, TracesState>(
                              builder: (tracescontext, state) {
                                if(state is FoundTracesState) {
                                  return Column(
                                    children: state.traces.map((e) => Container(
                                      margin: EdgeInsets.symmetric(vertical: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 4),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 32,
                                                      height: 32,
                                                      decoration: BoxDecoration(
                                                        color: primary,
                                                        borderRadius: BorderRadius.circular(12)
                                                      ),
                                                      child: Center(child: SvgPicture.asset('lib/assets/icons/avatar.svg', color: accent, width: 16,))
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(left: 12),
                                                      child: Text(
                                                        e.fullname,
                                                        style: TextStyle(
                                                          color: accent,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 4),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width: 32,
                                                        height: 32,
                                                        decoration: BoxDecoration(
                                                            color: primary,
                                                            borderRadius: BorderRadius.circular(12)
                                                        ),
                                                        child: Center(child: SvgPicture.asset('lib/assets/icons/phone.svg', color: accent, width: 16,))
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(left: 12),
                                                        child: Text(
                                                            e.mobile,
                                                          style: TextStyle(
                                                            color: accent,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 32),
                                            child: Text(
                                              format(e.date),
                                              style: TextStyle(
                                                color: accent,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          )
                                        ],
                                      )
                                    )).toList(),
                                  );
                                }

                                return Container();
                              },
                            ),
                          ),

                          Container(
                            height: 64,
                          )
                        ],
                      ),
                    )
                ),


                /*
                * and here we will have the send button...*/
                BlocConsumer<ContactsBloc, ContactsState>(
                  listener: (contactscheckin, state) {
                    if(state is ContactCreationFailedState) {
                      showDialog(context: context,
                        builder: (BuildContext context) => Error(exception: state.exception),
                        barrierDismissible: true,
                      );
                    }
                  },
                  builder: (contactscontext, state) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,

                      alignment: Alignment.bottomRight,

                      child: Container(
                          width: 180,
                          height: 64,

                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  bottomLeft: Radius.circular(32)
                              )
                          ),

                          child: Stack(
                            children: [
                              Center(

                                child: state is LoadingContactState ?
                                Container(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))
                                ) :
                                Text(
                                  'Send',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Material(
                                  color: Colors.transparent,

                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32),
                                      bottomLeft: Radius.circular(32)
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      BlocProvider.of<ContactsBloc>(contactscontext).add(CreateContact(
                                          name: name.text,
                                          number: number.text
                                      ));
                                    },
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(32),
                                        bottomLeft: Radius.circular(32)
                                    ),
                                    highlightColor: accent.withOpacity(0.24),
                                    splashColor: accent.withOpacity(0.16),
                                  )
                              ),
                            ],
                          )
                      ),
                    );
                  },
                ),
                /*
                * Here we will have the close button */
                Container(
                  margin: EdgeInsets.only(top: 32, left: 32),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                        width: 80,
                        height: 80,

                        child: Center(
                          child: Material(
                            color: Colors.black.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(40),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: SvgPicture.asset('lib/assets/icons/close.svg', color: Colors.black.withOpacity(0.48), width: 20),
                                ),

                                InkWell(
                                  borderRadius: BorderRadius.circular(40),
                                  highlightColor: Colors.black.withOpacity(0.24),
                                  splashColor: Colors.black.withOpacity(0.16),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }

}