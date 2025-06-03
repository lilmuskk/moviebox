import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieFormPage extends StatefulWidget {
  final Movie? movie;
  const MovieFormPage({super.key, this.movie});

  @override
  State<MovieFormPage> createState() => _MovieFormPageState();
}

class _MovieFormPageState extends State<MovieFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleCtrl;
  late TextEditingController genreCtrl;
  late TextEditingController yearCtrl;
  late TextEditingController imageUrlCtrl;
  late TextEditingController descCtrl;

  final List<String> genres = [
    'Action',
    'Drama',
    'Comedy',
    'Horror',
    'Sci-Fi',
    'Romance',
    'Fantasy',
    'Thriller',
    'Adult',
    'Musical'
  ];

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.movie?.title ?? '');
    genreCtrl = TextEditingController(text: widget.movie?.genre ?? '');
    yearCtrl = TextEditingController(text: widget.movie?.year.toString() ?? '');
    imageUrlCtrl = TextEditingController(text: widget.movie?.imageUrl ?? '');
    descCtrl = TextEditingController(text: widget.movie?.description ?? '');
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final movie = Movie(
        id: widget.movie?.id ?? '',
        title: titleCtrl.text,
        genre: genreCtrl.text,
        year: int.parse(yearCtrl.text),
        imageUrl: imageUrlCtrl.text,
        description: descCtrl.text,
      );

      if (widget.movie == null) {
        await MovieService.addMovie(movie);
      } else {
        await MovieService.updateMovie(movie.id!, movie);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.movie != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Movie' : 'Add Movie'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleCtrl,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: genreCtrl.text.isNotEmpty ? genreCtrl.text : null,
                decoration: InputDecoration(labelText: 'Genre'),
                items: genres.map((String genre) {
                  return DropdownMenuItem<String>(
                    value: genre,
                    child: Text(genre),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    genreCtrl.text = newValue!;
                  });
                },
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: yearCtrl,
                decoration: InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: imageUrlCtrl,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: descCtrl,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 4,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEdit ? 'Update' : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
