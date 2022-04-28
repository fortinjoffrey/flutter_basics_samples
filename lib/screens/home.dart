import 'package:basics_samples/model/job.dart';
import 'package:basics_samples/model/job_category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/theme_styles.dart';
import '../utils/theme_colors.dart';
import '../utils/widget_extension.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  final List<String> jobKeywords = [
    'Developer',
    'Agile',
    'Sales manager',
    'CEO',
    'Designer',
    'Project Owner'
  ];

  final List<JobCategory> jobCategories = [
    JobCategory(
        name: "Engineering", bgColor: Colors.teal[50]!, fgColor: Colors.teal),
    JobCategory(name: "Design", bgColor: Colors.blue[50]!, fgColor: Colors.blue),
    JobCategory(
        name: "Development", bgColor: Colors.red[50]!, fgColor: Colors.red),
    JobCategory(
        name: "Sales", bgColor: Colors.orange[50]!, fgColor: Colors.orange),
    JobCategory(
        name: "Marketing", bgColor: Colors.purple[50]!, fgColor: Colors.purple),
  ];

  final List<Job> jobs = [
    Job(
      title: 'UX/UI Design',
      company: 'Google',
      city: 'Mountain View, California',
      country: 'United States',
      imageName: 'google.png',
    ),
    Job(
      title: 'React developer',
      company: 'Facebook',
      city: 'Menlo Park, California',
      country: 'United States',
      imageName: 'facebook.png',
    ),
    Job(
      title: 'System engineer',
      company: 'Microsoft',
      city: 'Redmond, Washington',
      country: 'United States',
      imageName: 'microsoft.png',
    ),
  ];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu, color: Colors.black),
                onPressed: () {},
              ),
              Text('Hello John, Find your dream job', style: ThemeStyles.title),
              SizedBox(height: 16.0),
              _buildSearchRow(),
              SizedBox(height: 16.0),
              _buildJobKeywordsContainer(),
              SizedBox(height: 16.0),
              _buildPopularJobsContainer(),
              SizedBox(height: 16.0),
              _buildJobCategoryContainer()
            ],
          ),
        ),
      ).paddingAll(16.0),
    );
  }

  Container _buildJobCategoryContainer() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Job Category', style: ThemeStyles.headline1),
              Spacer(),
              Text('Show All', style: ThemeStyles.showMore),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            height: 50,
            child: _buildJobCategoryListView(),
          ),
        ],
      ),
    );
  }

  ListView _buildJobCategoryListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.jobCategories.length,
      itemBuilder: (context, index) {
        return _buildJobCategory(widget.jobCategories[index])
            .paddingOnly(right: 8.0);
      },
    );
  }

  Container _buildPopularJobsContainer() {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColors.ultraLightBlue,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Popular Jobs', style: ThemeStyles.headline1),
              Spacer(),
              Text('Show All', style: ThemeStyles.showMore),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            height: 150,
            child: _buildPopularJobsListView(),
          )
        ],
      ).paddingSymetric(horizontal: 12.0, vertical: 16.0),
    );
  }

  ListView _buildPopularJobsListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.jobs.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            openJobBottomSheet(context, widget.jobs[index]);
          },
          child: _buildJob(job: widget.jobs[index]).paddingOnly(right: 16.0),
        );
      },
    );
  }

  void openJobBottomSheet(BuildContext context, Job job) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          color: Colors.transparent,
          child: Container(
            height: 550,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 24.0,
                    ),
                    Spacer(),
                    Icon(
                      Icons.file_upload,
                      color: Colors.black,
                      size: 24.0,
                    )
                  ],
                ).paddingAll(8.0),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.ultraLightBlue,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Image.asset(
                      'assets/images/' + job.imageName,
                      height: 36.0,
                      width: 36.0,
                    ).paddingAll(50.0),
                  ),
                ),
                SizedBox(height: 4.0),
                Center(
                  child: Text(
                    job.title,
                    style: ThemeStyles.jobTitle,
                  ),
                ),
                SizedBox(height: 4.0),
                Center(
                  child: Text(
                    job.company + ' / ' + job.city + ', ' + job.country,
                    style: ThemeStyles.localisation,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          'Description',
                          style: ThemeStyles.jobDescription,
                        ),
                      ).paddingSymetric(horizontal: 8.0),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          'Company',
                          style: ThemeStyles.jobDescription
                              .copyWith(color: Colors.black45),
                        ),
                      ).paddingSymetric(horizontal: 8.0),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          'Reviews',
                          style: ThemeStyles.jobDescription
                              .copyWith(color: Colors.black45),
                        ),
                      ).paddingSymetric(horizontal: 8.0),
                    )
                  ],
                ),
                SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Minimum Qualification',
                      style: ThemeStyles.bodyHeadline,
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 3.0,
                        ).paddingAll(8.0),
                        SizedBox(width: 16.0),
                        Text(
                          "Bachelor's degree in design or \nequivalent practical experience",
                          style: ThemeStyles.bodyGrey,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 3.0,
                        ).paddingAll(8.0),
                        SizedBox(width: 16.0),
                        Text(
                          "Experience designing across\nmultiple platforms",
                          style: ThemeStyles.bodyGrey,
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200]!,
                        offset: Offset(-3, -3),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              'Apply here',
                              style: ThemeStyles.buttonTextLight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingAll(16.0),
                )
              ],
            ).paddingAll(8.0),
          ).paddingOnly(top: 8.0),
        );
      },
    );
  }

  Container _buildJobKeywordsContainer() {
    return Container(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.jobKeywords.length,
        itemBuilder: (context, index) {
          return _buildCategory(widget.jobKeywords[index])
              .paddingOnly(right: 8.0);
        },
      ),
    );
  }

  Row _buildSearchRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: ThemeColors.ultraLightBlue,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.search, color: Colors.grey, size: 16.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blue,
                    style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ).paddingSymetric(horizontal: 16.0),
          ),
        ),
        SizedBox(width: 16.0),
        Container(
          width: 32.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.ultraLightBlue,
          ),
          child: Icon(
            Icons.sort,
            color: Colors.black,
            size: 16.0,
          ).paddingAll(8.0),
        )
      ],
    );
  }

  Container _buildCategory(String name) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Text(
          name,
          style: GoogleFonts.nunitoSans(
            color: Colors.blueGrey,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            fontSize: 12.0,
          ),
        ).paddingAll(8.0),
      ),
    );
  }

  Container _buildJob({
    required Job job,
  }) {
    return Container(
      width: 275,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: ThemeColors.ultraLightBlue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.asset(
                  'assets/images/' + job.imageName,
                  height: 24.0,
                  width: 24.0,
                ),
              ),
              Spacer(),
              Icon(
                Icons.favorite_border,
                color: Colors.grey,
                size: 12.0,
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Text(job.company, style: ThemeStyles.company),
          SizedBox(height: 4.0),
          Text(job.title, style: ThemeStyles.jobTitle),
          SizedBox(height: 4.0),
          // Text('Mountain View, California', style: ThemeStyles.localisation),
          Text(job.city, style: ThemeStyles.localisation),
          SizedBox(height: 4.0),
          Text(job.country, style: ThemeStyles.localisation),
          SizedBox(height: 4.0),
        ],
      ).paddingAll(14.0),
    );
  }

  Container _buildJobCategory(JobCategory category) {
    return Container(
      decoration: BoxDecoration(
        color: category.bgColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Text(
          category.name,
          style: GoogleFonts.nunitoSans(
            color: category.fgColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            fontSize: 14,
          ),
        ),
      ).paddingSymetric(horizontal: 8.0),
    );
  }
}
