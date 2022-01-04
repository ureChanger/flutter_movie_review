import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_review/model/data/dummys_repository.dart';
import 'package:movie_review/model/widet/star_rating_bar.dart';
import 'comment_page.dart';
import 'model/response/comments_response.dart';
import 'model/response/movie_response.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  late String movieId;

  DetailPage(this.movieId);

  @override
  State<StatefulWidget> createState() => _DetailState(movieId);
}

class _DetailState extends State<DetailPage> {
  String movieId;
  late String _movieTitle = '';
  late MovieResponse _movieResponse;
  late CommentsResponse _commentsResponse;

  _DetailState(this.movieId);

  @override
  Widget build(BuildContext context) {
    _movieResponse = DummysRepository.loadDummyMovie(movieId);
    _commentsResponse = DummysRepository.loadComments(movieId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents(){
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildMovieSummary(),
          _buildMovieSynopsis(),
          _buildMovieCast(),
          _buildComment(),
        ],
      ),
    );
  }

  // Summary 화면
  Widget _buildMovieSummary(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.network(_movieResponse.image, height: 180,),
            SizedBox(width: 10,),
            _buildMovieSummaryTextColumn(),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildReservationRate(),
            _buildVerticalDivider(),
            _buildUserRating(),
            _buildVerticalDivider(),
            _buildAudience(),
          ],
        ),
      ],
    );
  }

  Widget _buildMovieSummaryTextColumn(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _movieResponse.title,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        Text(
          '${_movieResponse.date} 개봉',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          '${_movieResponse.genre} / ${_movieResponse.duration}분',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildReservationRate(){
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '예매율',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              '${_movieResponse.reservationGrade}위 ${_movieResponse.reservationRate.toString()}%'
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserRating(){
    return Column(
      children: [
        Text(
          '평점',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10,),
        Text('${_movieResponse.userRating / 2}'),
      ],
    );
  }

  Widget _buildAudience(){
    final numberFormatter = NumberFormat.decimalPattern();
    return Column(
      children: [
        Text(
          '누적관객수',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10,),
        Text(numberFormatter.format(_movieResponse.audience)),
      ],
    );
  }

  Widget _buildVerticalDivider(){
    return Container(
      width: 1,
      height: 50,
      color: Colors.grey,
    );
  }


  Widget _buildMovieSynopsis(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          height: 10,
          color: Colors.grey.shade400,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            '줄거리',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Text(_movieResponse.synopsis),
        )
      ],
    );
  }

  Widget _buildMovieCast(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          color: Colors.grey.shade400,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '감독/출연',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '감독',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(_movieResponse.director),
                  ],
              ),
              Row(
                children: [
                  Text(
                    '출연',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(child: Text(_movieResponse.actor)),
                  ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComment(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          height: 10,
          color: Colors.grey.shade400,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '한줄평',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              IconButton(
                  onPressed: () => _presentCommentPage(context),
                  icon: Icon(Icons.create),
                  color: Colors.blue,
              )
            ],
          ),
        ),
        _buildCommentListView()
      ],
    );
  }

  Widget _buildCommentListView(){
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.all(10.0),
        itemCount: _commentsResponse.comments.length,
        itemBuilder: (_, index) =>
            _buildItem(comment: _commentsResponse.comments[index]),
    );
  }

  Widget _buildItem({required Comment comment}){
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.person_pin, size: 50,),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(comment.writer),
                  SizedBox(width: 5,),
                  StarRatingBar(
                    rating: comment.rating.toInt(),
                    isUserInteractionEnabled: false,
                    size: 20, onRatingChanged: (int ) {  },
                  )
                ],
              ),
              Text(_convertTimeStampToDataTime(comment.timestamp)),
              SizedBox(height: 5,),
              Text(comment.contents),
            ],
          )
        ],
      ),
    );
  }

  String _convertTimeStampToDataTime(int timestamp){
    final dateFormatter = DateFormat('yyyy-mm-dd HH:mm:ss');
    return dateFormatter.format(DateTime.fromMicrosecondsSinceEpoch(timestamp*1000));
  }

  void _presentCommentPage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CommentPage(
          _movieResponse.title,
          _movieResponse.id,
        ),
    ));
  }

}

