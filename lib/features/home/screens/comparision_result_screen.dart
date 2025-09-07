import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tajwid/app/themes/app_colors.dart';
import 'package:tajwid/core/extensions/routes_extenstion.dart';
import 'package:tajwid/features/home/model/comparision_result_model.dart';
import 'package:tajwid/features/home/provider/home_provider.dart';

class ComparisionResultScreen extends StatelessWidget {
  const ComparisionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30.h,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Pronunciation Analysis',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: AppColors.textWhiteColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Overall Score Card
            _buildOverallScoreCard(context),
            SizedBox(height: 20),

            // Transcription Card
            _buildTranscriptionCard(context),
            SizedBox(height: 20),

            // Speaker Similarity Card
            _buildSpeakerSimilarityCard(context),
            SizedBox(height: 20),

            // Acoustic Analysis Card
            _buildAcousticAnalysisCard(context),
            SizedBox(height: 20),

            // Pronunciation Accuracy Card
            _buildPronunciationAccuracyCard(context),
            SizedBox(height: 20),

            // Visualization Card
            _buildVisualizationCard(context),
            SizedBox(height: 20),

            // Analysis Details Card
            _buildAnalysisDetailsCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallScoreCard(BuildContext context) {
    double score =
        context.watch<HomeProvider>().comparisionResult?.overallScore ?? 0;
    double percentage = score * 100;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black54],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Text(
              'Overall Pronunciation Score',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: score,
                    strokeWidth: 12,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${percentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _getScoreGrade(score),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTranscriptionCard(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.translate, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Transcription',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reference (Qari):',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    context
                            .watch<HomeProvider>()
                            .comparisionResult
                            ?.transcriptions
                            ?.reference ??
                        "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Arabic',
                    ),
                    // textDirection: TextDirection.RTL.,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Your Pronunciation:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    context
                            .watch<HomeProvider>()
                            .comparisionResult
                            ?.transcriptions
                            ?.comparison ??
                        "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Arabic',
                    ),
                    // textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeakerSimilarityCard(BuildContext context) {
    double similarity =
        context.watch<HomeProvider>().comparisionResult?.speakerSimilarity ?? 0;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person_outline, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Speaker Similarity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            LinearProgressIndicator(
              value: similarity,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getColorForScore(similarity),
              ),
              minHeight: 8,
            ),
            SizedBox(height: 8),
            Text(
              '${(similarity * 100).toStringAsFixed(1)}% similarity to reference',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcousticAnalysisCard(BuildContext context) {
    AcousticComparison acoustic =
        context.watch<HomeProvider>().comparisionResult!.acousticComparison!;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.graphic_eq, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Acoustic Analysis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildAcousticMetric(
              'RMS Energy',
              acoustic.rmsEnergyCorrelation ?? 0,
            ),
            _buildAcousticMetric(
              'Zero Crossing Rate',
              acoustic.zeroCrossingRateCorrelation ?? 0,
            ),
            _buildAcousticMetric(
              'Spectral Centroid',
              acoustic.spectralCentroidCorrelation ?? 0,
            ),
            _buildAcousticMetric(
              'Spectral Bandwidth',
              acoustic.spectralBandwidthCorrelation ?? 0,
            ),
            _buildAcousticMetric(
              'Pitch Correlation',
              acoustic.pitchCorrelation ?? 0,
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange[700], size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'MFCC DTW Distance: ${acoustic.mfccDtwDistance?.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcousticMetric(String name, double value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                value.toStringAsFixed(3),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _getColorForCorrelation(value),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          LinearProgressIndicator(
            value: (value + 1) / 2, // Normalize from [-1, 1] to [0, 1]
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              _getColorForCorrelation(value),
            ),
            minHeight: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildPronunciationAccuracyCard(BuildContext context) {
    context.watch<HomeProvider>().comparisionResult!.pronunciationDifferences;
    bool isPerfect =
        context
                .watch<HomeProvider>()
                .comparisionResult!
                .pronunciationDifferences
                ?.levenshteinDistance ==
            0 &&
        context
                .watch<HomeProvider>()
                .comparisionResult!
                .pronunciationDifferences
                ?.lengthDifference ==
            0;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle_outline, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Pronunciation Accuracy',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isPerfect ? Colors.green[50] : Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isPerfect ? Colors.green[200]! : Colors.orange[200]!,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        isPerfect ? Icons.check_circle : Icons.warning,
                        color:
                            isPerfect ? Colors.green[700] : Colors.orange[700],
                      ),
                      SizedBox(width: 8),
                      Text(
                        isPerfect ? 'Perfect Match!' : 'Minor Differences',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              isPerfect
                                  ? Colors.green[700]
                                  : Colors.orange[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${context.watch<HomeProvider>().comparisionResult!.pronunciationDifferences?.levenshteinDistance}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:
                                  isPerfect
                                      ? Colors.green[700]
                                      : Colors.orange[700],
                            ),
                          ),
                          Text(
                            'Edit Distance',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${context.watch<HomeProvider>().comparisionResult!.pronunciationDifferences?.lengthDifference}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:
                                  isPerfect
                                      ? Colors.green[700]
                                      : Colors.orange[700],
                            ),
                          ),
                          Text(
                            'Length Diff',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisualizationCard(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.show_chart, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Audio Visualization',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  context
                          .watch<HomeProvider>()
                          .comparisionResult
                          ?.visualizationUrl ??
                      "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[100],
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image,
                              size: 40,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text('Visualization not available'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisDetailsCard(BuildContext context) {
    DateTime createdAt = DateTime.parse(
      context.watch<HomeProvider>().comparisionResult?.createdAt ?? "",
    );

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Analysis Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildDetailRow(
              'Analysis ID',
              context.watch<HomeProvider>().comparisionResult?.id.toString() ??
                  "",
            ),
            _buildDetailRow(
              'Reference Audio',
              context
                      .watch<HomeProvider>()
                      .comparisionResult
                      ?.referenceAudio
                      .toString() ??
                  "",
            ),
            _buildDetailRow(
              'Your Audio',
              context
                      .watch<HomeProvider>()
                      .comparisionResult
                      ?.comparisonAudio ??
                  " ",
            ),
            _buildDetailRow(
              'Created',
              DateFormat('MMM dd, yyyy • HH:mm').format(createdAt),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  String _getScoreGrade(double score) {
    if (score >= 0.9) return 'Excellent';
    if (score >= 0.8) return 'Very Good';
    if (score >= 0.7) return 'Good';
    if (score >= 0.6) return 'Fair';
    return 'Needs Practice';
  }

  Color _getColorForScore(double score) {
    if (score >= 0.8) return Colors.green;
    if (score >= 0.6) return Colors.orange;
    return Colors.red;
  }

  Color _getColorForCorrelation(double correlation) {
    double absCorr = correlation.abs();
    if (absCorr >= 0.5) return Colors.green;
    if (absCorr >= 0.3) return Colors.orange;
    return Colors.red;
  }
}
