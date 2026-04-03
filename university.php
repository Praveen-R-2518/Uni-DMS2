<?php
require_once 'includes/db.php';

$pageStyles = ['css/pages/universities.css'];

$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
$university = null;
$degrees = [];

$groupedDegrees = [];

if ($id) {
    $stmt = $conn->prepare('SELECT * FROM universities WHERE id = ? LIMIT 1');
    if ($stmt) {
        $stmt->bind_param('i', $id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result && ($row = $result->fetch_assoc())) {
            $university = $row;
        }
        $stmt->close();
    }
}

if ($university) {
    $uniName = $university['name'];
    $degreeUniversityNames = [$uniName];
    if ($uniName === 'University of Trincomalee') {
        $degreeUniversityNames[] = 'Trincomalee Campus, Eastern University, Sri Lanka';
    }

    $placeholders = implode(', ', array_fill(0, count($degreeUniversityNames), '?'));
    $degreeStmt = $conn->prepare('
        SELECT DISTINCT 
            fz.degree_name, 
            fz.subject1, 
            fz.subject2, 
            fz.subject3,
            d.duration,
            d.medium,
            d.description,
            fac.name AS faculty_name
        FROM flat_zscores fz
        LEFT JOIN degrees d ON d.name = fz.degree_name
        LEFT JOIN departments dep ON d.department_id = dep.id
        LEFT JOIN faculties fac ON dep.faculty_id = fac.id AND fac.university_id = ?
        WHERE fz.university_name IN (' . $placeholders . ')
        ORDER BY fz.degree_name ASC
    ');

    if ($degreeStmt) {
        $bindTypes = 'i' . str_repeat('s', count($degreeUniversityNames));
        $bindValues = array_merge([$id], $degreeUniversityNames);
        $degreeStmt->bind_param($bindTypes, ...$bindValues);
        $degreeStmt->execute();
        $degrees = $degreeStmt->get_result()->fetch_all(MYSQLI_ASSOC);
        $degreeStmt->close();

        foreach ($degrees as $deg) {
            $sub1 = strtoupper($deg['subject1'] ?? '');
            $sub2 = strtoupper($deg['subject2'] ?? '');
            $sub3 = strtoupper($deg['subject3'] ?? '');
            $degUpper = strtoupper($deg['degree_name']);
            $subs = $sub1 . " " . $sub2 . " " . $sub3;
            
            $stream = 'Other Programs';
            if (strpos($subs, 'COMBINED MATHEMATICS') !== false) {
                $stream = 'Maths';
            } elseif (strpos($subs, 'BIOLOGY') !== false) {
                $stream = 'Bio';
            } elseif (strpos($subs, 'ACCOUNTING') !== false || strpos($subs, 'BUSINESS') !== false || strpos($subs, 'ECONOMICS') !== false || strpos($degUpper, 'MANAGEMENT') !== false || strpos($degUpper, 'COMMERCE') !== false) {
                $stream = 'Commerce';
            } elseif (strpos($subs, 'ANY') !== false || strpos($degUpper, 'ARTS') !== false || strpos($degUpper, 'LANGUAGES') !== false) {
                $stream = 'Arts';
            } else {
                if (strpos($degUpper, 'MEDICINE') !== false || strpos($degUpper, 'DENTAL') !== false || strpos($degUpper, 'BIOLOGICAL') !== false) {
                    $stream = 'Bio';
                } elseif (strpos($degUpper, 'ENGINEERING') !== false || strpos($degUpper, 'PHYSICAL') !== false || strpos($degUpper, 'ICT') !== false || strpos($degUpper, 'COMPUTER') !== false) {
                    $stream = 'Maths';
                }
            }
            
            if (!isset($groupedDegrees[$stream])) {
                $groupedDegrees[$stream] = [];
            }
            $groupedDegrees[$stream][] = $deg;
        }
    }
}

$heroDescription = '';
if ($university) {
    $heroDescription = !empty($university['description'])
        ? $university['description']
        : 'Discover programs and opportunities at this institution.';
    if (strlen($heroDescription) > 320) {
        $heroDescription = substr($heroDescription, 0, 320) . '...';
    }
}

include 'includes/header.php';
?>
<?php if ($university): ?>
    <section class="page-hero reveal-on-scroll detail-hero">
        <div class="container">
            <div class="hero-text">
                <h1><?php echo htmlspecialchars($university['name']); ?></h1>
                <p class="page-hero-meta"><?php echo htmlspecialchars($heroDescription); ?></p>
            </div>
        </div>
    </section>

    <section class="container reveal-on-scroll university-programs">
        <div class="section-heading section-heading--compact">
            <h2>Featured degrees</h2>
            <p class="section-subtitle">Grouped by stream for easier browsing and comparison.</p>
        </div>
        <?php if (!empty($groupedDegrees)): ?>
            <div class="program-streams">
                <?php foreach ($groupedDegrees as $streamName => $streamDegrees): ?>
                    <section class="program-stream">
                        <div class="stream-header">
                            <div>
                                <p class="stream-kicker">Academic stream</p>
                                <h3 class="stream-title"><?php echo htmlspecialchars($streamName); ?></h3>
                            </div>
                            <span class="stream-count"><?php echo count($streamDegrees); ?> programs</span>
                        </div>
                        <div class="program-grid">
                            <?php foreach ($streamDegrees as $degree): ?>
                                <article class="program-card reveal-on-scroll">
                                    <div class="program-card__accent"></div>
                                    <div class="program-card__body">
                                        <h4><?php echo htmlspecialchars($degree['degree_name']); ?></h4>
                                        <div class="program-meta">
                                            <?php if (!empty($degree['faculty_name'])): ?>
                                                <div class="program-meta__item">
                                                    <span class="program-meta__label">Faculty</span>
                                                    <span class="program-meta__value"><?php echo htmlspecialchars($degree['faculty_name']); ?></span>
                                                </div>
                                            <?php endif; ?>
                                            <?php if (!empty($degree['duration'])): ?>
                                                <div class="program-meta__item">
                                                    <span class="program-meta__label">Duration</span>
                                                    <span class="program-meta__value"><?php echo htmlspecialchars($degree['duration']); ?></span>
                                                </div>
                                            <?php endif; ?>
                                            <?php if (!empty($degree['medium'])): ?>
                                                <div class="program-meta__item">
                                                    <span class="program-meta__label">Medium</span>
                                                    <span class="program-meta__value"><?php echo htmlspecialchars($degree['medium']); ?></span>
                                                </div>
                                            <?php endif; ?>
                                        </div>
                                        <?php if (!empty($degree['description'])): ?>
                                            <p class="program-description"><?php echo htmlspecialchars($degree['description']); ?></p>
                                        <?php endif; ?>
                                    </div>
                                </article>
                            <?php endforeach; ?>
                        </div>
                    </section>
                <?php endforeach; ?>
            </div>
        <?php else: ?>
            <p class="section-subtitle">No cataloged degrees are visible right now. Check back soon.</p>
        <?php endif; ?>
    </section>
<?php else: ?>
    <section class="page-hero reveal-on-scroll">
        <div class="container">
            <p class="eyebrow">University not found</p>
            <h1>We could not locate that university.</h1>
            <p class="page-hero-meta">Return to the directory and continue your exploration.</p>
            <div class="breadcrumb">
                <a href="/index.php">Home</a>
                <span> / </span>
                <a href="/universities.php">Universities</a>
            </div>
        </div>
    </section>
<?php endif; ?>

<?php include 'includes/footer.php'; ?>