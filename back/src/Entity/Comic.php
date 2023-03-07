<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Repository\ComicRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;

use ApiPlatform\Metadata\Get;

#[Get]
#[ORM\Entity(repositoryClass: ComicRepository::class)]
#[ApiResource]
class Comic
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $name = null;

    #[ORM\Column]
    private ?int $nb_page = null;

    #[ORM\ManyToOne(inversedBy: 'comics')]
    #[ORM\JoinColumn(nullable: false)]
    private ?ComicsCollection $ComicsCollection = null;

    #[ORM\Column(length: 255)]
    private ?string $extension = null;

    #[ORM\Column]
    private ?int $credits = null;

    #[ORM\Column(nullable: true)]
    private ?float $note = null;

    #[ORM\Column(type: Types::TEXT)]
    private ?string $usersWhoNoted = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getNbPage(): ?int
    {
        return $this->nb_page;
    }

    public function setNbPage(int $nb_page): self
    {
        $this->nb_page = $nb_page;

        return $this;
    }

    public function getComicsCollection(): ?ComicsCollection
    {
        return $this->ComicsCollection;
    }

    public function setComicsCollection(?ComicsCollection $ComicsCollection): self
    {
        $this->ComicsCollection = $ComicsCollection;

        return $this;
    }

    public function getExtension(): ?string
    {
        return $this->extension;
    }

    public function setExtension(string $extension): self
    {
        $this->extension = $extension;

        return $this;
    }

    public function getCredits(): ?int
    {
        return $this->credits;
    }

    public function setCredits(int $credits): self
    {
        $this->credits = $credits;

        return $this;
    }

    public function getNote(): ?int
    {
        return $this->note;
    }

    public function setNote(?float $note): self
    {
        $this->note = $note;

        return $this;
    }

    public function getUsersWhoNoted(): ?string
    {
        return $this->usersWhoNoted;
    }

    public function setUsersWhoNoted(string $usersWhoNoted): self
    {
        $this->usersWhoNoted = $usersWhoNoted;

        return $this;
    }
}
