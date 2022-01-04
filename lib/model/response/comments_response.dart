class CommentsResponse {
  late String movieId;
  late List<Comment> comments;

  CommentsResponse(this.movieId, this.comments);

  // map 구조에서 새로운 CommentsResponse 객체를 생성
  CommentsResponse.fromJson(Map<String, dynamic> json) {
    movieId = json['movie_id'];
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((comment) {
        comments.add(Comment.fromJson(comment));
      });
    }
  }

  // CommentsResponse 객체를 map 구조로 변환
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['movie_id'] = movieId;
    if (comments != null) {
      map['comments'] = comments.map((comment) => comment.toMap()).toList();
    }
    return map;
  }
}

class Comment {
  // 평점 (1 ~ 10)
  late int rating;
  // 한줄평 고유 ID
  late String id;
  // 작성일시 UnixStamp 값
  late int timestamp;
  // 작성자
  late String writer;
  // 한줄평 내용
  late String contents;
  // 영화 고유 ID
  late String movieId;

  Comment({
    required this.rating,
    required this.id,
    required this.timestamp,
    required this.writer,
    required this.contents,
    required this.movieId
  });

  Comment.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    id = json['id'];
    timestamp = json['timestamp'];
    writer = json['writer'];
    contents = json['contents'];
    movieId = json['movie_id'];
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['rating'] = rating;
    map['id'] = id;
    map['timestamp'] = timestamp;
    map['writer'] = writer;
    map['contents'] = contents;
    map['movie_id'] = movieId;
    return map;
  }
}