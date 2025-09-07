// ignore_for_file: public_member_api_docs, sort_constructors_first
class ComparisionResultModel {
  final String? id;
  final String? userId;
  final String? referenceAudio;
  final String? comparisonAudio;
  final double? speakerSimilarity;
  final AcousticComparison? acousticComparison;
  final PronunciationDifferences? pronunciationDifferences;
  final Transcriptions? transcriptions;
  final double? overallScore;
  final String? visualizationUrl;
  final String? createdAt;
  final String? updatedAt;
  const ComparisionResultModel({
    this.id,
    this.userId,
    this.referenceAudio,
    this.comparisonAudio,
    this.speakerSimilarity,
    this.acousticComparison,
    this.pronunciationDifferences,
    this.transcriptions,
    this.overallScore,
    this.visualizationUrl,
    this.createdAt,
    this.updatedAt,
  });

  static ComparisionResultModel fromJson(Map<String, Object?> json) {
    return ComparisionResultModel(
      id: json['_id'] == null ? null : json['_id'] as String,
      userId: json['user_id'] == null ? null : json['user_id'] as String,
      referenceAudio:
          json['reference_audio'] == null
              ? null
              : json['reference_audio'] as String,
      comparisonAudio:
          json['comparison_audio'] == null
              ? null
              : json['comparison_audio'] as String,
      speakerSimilarity:
          json['speaker_similarity'] == null
              ? null
              : json['speaker_similarity'] as double,
      acousticComparison:
          json['acoustic_comparison'] == null
              ? null
              : AcousticComparison.fromJson(
                json['acoustic_comparison'] as Map<String, Object?>,
              ),
      pronunciationDifferences:
          json['pronunciation_differences'] == null
              ? null
              : PronunciationDifferences.fromJson(
                json['pronunciation_differences'] as Map<String, Object?>,
              ),
      transcriptions:
          json['transcriptions'] == null
              ? null
              : Transcriptions.fromJson(
                json['transcriptions'] as Map<String, Object?>,
              ),
      overallScore:
          json['overall_score'] == null
              ? null
              : json['overall_score'] as double,
      visualizationUrl:
          json['visualization_url'] == null
              ? null
              : json['visualization_url'] as String,
      createdAt:
          json['created_at'] == null ? null : json['created_at'] as String,
      updatedAt:
          json['updated_at'] == null ? null : json['updated_at'] as String,
    );
  }

  @override
  String toString() {
    return 'ComparisionResultModel(id: $id, userId: $userId, referenceAudio: $referenceAudio, comparisonAudio: $comparisonAudio, speakerSimilarity: $speakerSimilarity, acousticComparison: $acousticComparison, pronunciationDifferences: $pronunciationDifferences, transcriptions: $transcriptions, overallScore: $overallScore, visualizationUrl: $visualizationUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

class Transcriptions {
  final String? reference;
  final String? comparison;
  const Transcriptions({this.reference, this.comparison});

  static Transcriptions fromJson(Map<String, Object?> json) {
    return Transcriptions(
      reference: json['reference'] == null ? null : json['reference'] as String,
      comparison:
          json['comparison'] == null ? null : json['comparison'] as String,
    );
  }
}

class PronunciationDifferences {
  final int? levenshteinDistance;
  final int? lengthDifference;
  const PronunciationDifferences({
    this.levenshteinDistance,
    this.lengthDifference,
  });

  static PronunciationDifferences fromJson(Map<String, Object?> json) {
    return PronunciationDifferences(
      levenshteinDistance:
          json['levenshtein_distance'] == null
              ? null
              : json['levenshtein_distance'] as int,
      lengthDifference:
          json['length_difference'] == null
              ? null
              : json['length_difference'] as int,
    );
  }
}

class AcousticComparison {
  final double? rmsEnergyCorrelation;
  final double? zeroCrossingRateCorrelation;
  final double? spectralCentroidCorrelation;
  final double? spectralBandwidthCorrelation;
  final double? mfccDtwDistance;
  final double? pitchCorrelation;
  const AcousticComparison({
    this.rmsEnergyCorrelation,
    this.zeroCrossingRateCorrelation,
    this.spectralCentroidCorrelation,
    this.spectralBandwidthCorrelation,
    this.mfccDtwDistance,
    this.pitchCorrelation,
  });

  static AcousticComparison fromJson(Map<String, Object?> json) {
    return AcousticComparison(
      rmsEnergyCorrelation:
          json['rms_energy_correlation'] == null
              ? null
              : json['rms_energy_correlation'] as double,
      zeroCrossingRateCorrelation:
          json['zero_crossing_rate_correlation'] == null
              ? null
              : json['zero_crossing_rate_correlation'] as double,
      spectralCentroidCorrelation:
          json['spectral_centroid_correlation'] == null
              ? null
              : json['spectral_centroid_correlation'] as double,
      spectralBandwidthCorrelation:
          json['spectral_bandwidth_correlation'] == null
              ? null
              : json['spectral_bandwidth_correlation'] as double,
      mfccDtwDistance:
          json['mfcc_dtw_distance'] == null
              ? null
              : json['mfcc_dtw_distance'] as double,
      pitchCorrelation:
          json['pitch_correlation'] == null
              ? null
              : json['pitch_correlation'] as double,
    );
  }
}
