import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:io';
import 'dart:convert';

import '../../models/popular_video.dart';
import '../../layouts/main.dart';
import '../../helpers/helpers.dart';

class DetailVideo extends StatefulWidget {
  final PopularVideo popularVideo;
  DetailVideo(this.popularVideo);
  @override
  _DetailVideoState createState() => _DetailVideoState();
}

class _DetailVideoState extends State<DetailVideo> {
  bool _isFavorited;
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _getFavorite();
  }

  void _getFavorite() async {
    final response =
        await callApi().get('/favorite/check/' + widget.popularVideo.id);
    setState(() {
      _isFavorited = response.data == '1';
    });
  }

  void _toggleFavorite() async {
    final response = await callApi().post(
      '/favorite/toggle',
      data: widget.popularVideo.toJson(),
    );
    if (response.data['status']) {
      setState(() {
        _isFavorited = !_isFavorited;
      });
    }
    showToast(
      type: response.data['status'] ? 'success' : 'error',
      message: response.data['message'],
    );
  }

  @override
  Widget build(BuildContext context) {
    String videoPlayer = """<iframe
          id="vjs_video_3_Youtube_api"
          class="vjs-tech holds-the-iframe"
          frameborder="0"
          style="width: 100%; height: 100%"
          allowfullscreen="1"
          allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
          webkitallowfullscreen mozallowfullscreen allowfullscreen
          title="Live Tv"
          frameborder="0"
          src="https://www.youtube.com/embed/${widget.popularVideo.id}"
          ></iframe>
  """;

    final String videoPlayerBase64 =
        base64Encode(const Utf8Encoder().convert(videoPlayer));
    return Scaffold(
        appBar: AppBar(title: Text(widget.popularVideo.title)),
        body: MainLayout(
          scrollable: true,
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 10,
                  child: WebView(
                    initialUrl: 'data:text/html;base64,$videoPlayerBase64',
                    javascriptMode: JavascriptMode.unrestricted,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(widget.popularVideo.title),
                      Divider(),
                      Text(
                        'Tag Video',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        children: widget.popularVideo.tags
                            .map((tag) => InputChip(
                                  label: Text(tag),
                                ))
                            .toList(),
                        spacing: 8,
                      ),
                      Divider(),
                      Text(
                        'Deskripsi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(widget.popularVideo.description),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: () {
          if (_isFavorited == null) {
            return SizedBox();
          } else {
            return FloatingActionButton(
              onPressed: () => _toggleFavorite(),
              child:
                  Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
            );
          }
        }());
  }
}
