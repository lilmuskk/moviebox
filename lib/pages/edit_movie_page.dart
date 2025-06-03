import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class EditMoviePage extends StatefulWidget {
  final Movie movie;
  const EditMoviePage({Key? key, required this.movie}) : super(key: key);

  @override
  State<EditMoviePage> createState() => _EditMoviePageState();
}

class _EditMoviePageState extends State<EditMoviePage> {
  late TextEditingController titleController;
  late TextEditingController genreController;
  late TextEditingController yearController;
  late TextEditingController descriptionController;
  late TextEditingController imageUrlController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.movie.title);
    genreController = TextEditingController(text: widget.movie.genre);
    yearController = TextEditingController(text: widget.movie.year.toString());
    descriptionController = TextEditingController(text: widget.movie.description);
    imageUrlController = TextEditingController(text: widget.movie.imageUrl);
  }

  @override
  void dispose() {
    titleController.dispose();
    genreController.dispose();
    yearController.dispose();
    descriptionController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      isLoading = true;
    });

    final updatedMovie = Movie(
      id: widget.movie.id,
      title: titleController.text,
      genre: genreController.text,
      year: int.tryParse(yearController.text) ?? widget.movie.year,
      description: descriptionController.text,
      imageUrl: imageUrlController.text,
    );

    try {
      await MovieService.updateMovie(widget.movie.id, updatedMovie);
      Navigator.pop(context, true); // kasih tau sudah update
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal update movie: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Movie'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: genreController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            TextField(
              controller: yearController,
              decoration: InputDecoration(labelText: 'Year'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : ElevatedButton(
              onPressed: _submit,
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
